extends Camera2D

export var move_speed = 1  # camera position lerp speed
export var zoom_speed = 0.25  # camera zoom lerp speed
export var min_zoom = 1.5  # camera won't zoom closer than this
export var max_zoom = 5  # camera won't zoom farther than this
export var margin = Vector2(400, 200)  # include some buffer area around targets

var targets = []  # Array of targets to be tracked.

onready var screen_size = get_viewport_rect().size

func _process(_delta):
    if !targets:
        return
    # Keep the camera centered between the targets
    var p = Vector2.ZERO
    for target in targets:
        p += target.position
    p /= targets.size()
    position = lerp(position, p, move_speed)
    # Find the zoom that will contain all targets
    var r = Rect2(position, Vector2.ONE)
    
    #left, top, right, bottom
    var cam_bounds = []
    
    for i in range(4):
        if i%2 == 0:
            cam_bounds.append(margin.x)
        else:
            cam_bounds.append(margin.y)
    
    for target in targets:
        r = r.expand(target.position)
        if target.position.x - limit_left < margin.x:
            cam_bounds[0] = target.position.x - limit_left
        if target.position.y - limit_top < margin.y:
            cam_bounds[1] = target.position.y - limit_top
        if limit_right - target.position.x < margin.x:
            cam_bounds[2] = limit_right - target.position.x
        if limit_bottom - target.position.y < margin.y:
            cam_bounds[3] = limit_bottom - target.position.y
    r = r.grow_individual(cam_bounds[0], cam_bounds[1], cam_bounds[2], cam_bounds[3])
    # var d = max(r.size.x, r.size.y)
    var z
    if r.size.x > r.size.y * screen_size.aspect():
        z = clamp(r.size.x / screen_size.x, min_zoom, max_zoom)
    else:
        z = clamp(r.size.y / screen_size.y, min_zoom, max_zoom)
    zoom = lerp(zoom, Vector2.ONE * z, zoom_speed)

func add_target(t):
    if not t in targets:
        targets.append(t)

func remove_target(t):
    if t in targets:
        targets.erase(t)

func add_targets(ts):
    for t in ts:
        if not t in targets:
            targets.append(t)

func clear_targets():
    targets.clear()
