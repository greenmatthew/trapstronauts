extends KinematicBody2D
class_name Laserwithdrone

onready var raycast = $RayCast2D
onready var particles = $Particles2D

const direction : Vector2 = Vector2.RIGHT
const max_range : float = 320.0

const duration : float = 1.5
var time : float = 0.0

var disabled: bool = false

var is_on : bool = false
var time_on : float = 0.0


var speed  = 120
var motion = Vector2.ZERO
var player = null

func _ready() -> void:
    set_process(true)
    var _status = EventHandler.connect("timer", self, "on_timer_signal")
    raycast.enabled = true
    raycast.collide_with_bodies = true
    raycast.collide_with_areas = false
    raycast.exclude_parent = true
    raycast.cast_to = motion * max_range
    if duration >= EventHandler.timer_interval:
        printerr("Duration of trap is longer than timer interval. This will cause the trap to permenantly be on.")

func _physics_process(_delta):
    motion = Vector2.ZERO
    if player:
        motion = global_position.direction_to(player.position) * speed
        motion = move_and_slide(motion)
        raycast.cast_to = raycast.to_local(player.position)
    

func _process(delta : float) -> void:
    if disabled:
        return
        
    update()
    if int(floor(time_on / duration)) >= 1:
        is_on = false
    time_on += delta

func _draw():
    if is_on and !disabled:
        $AudioStreamPlayer.play()
        particles.emitting = true
        if raycast.is_colliding():
            draw_laser( abs(raycast.to_local(raycast.get_collision_point()).x) )
            var collider = raycast.get_collider()
            if collider is PlayerController:
                EventHandler.emit_signal("player_killed", collider, get_parent())
        else:
            draw_laser(max_range)
    else:
        $AudioStreamPlayer.stop()
        particles.emitting = false

func on_timer_signal():
    is_on = true
    time_on = 0.0

func get_raycast_center() -> Vector2:
    return raycast.global_position

func get_raycast_relative_center() -> Vector2:
    return to_local(raycast.global_position)

func draw_laser(distance : float) -> void:
    var to = motion * distance + get_raycast_relative_center()
    var from = get_raycast_relative_center()
    draw_line(from, to, Color.darkred, 16)
    draw_line(from, to, Color.red, 12)
    draw_line(from, to, Color.white, 8)
    particles.position = to

func _on_Area2D_body_entered(body):
    if body is PlayerController:
        player = body

func _on_Area2D_body_exited(body):
    # print('Player has exited')
    if body is PlayerController:
        player = null
    
func disable() -> void:
    player = null
    $CollisionShape2D.set_deferred("disabled", true)
    $Area2D/CollisionShape2D.set_deferred("disabled", true)
    disabled = true

func enable() -> void:
    $CollisionShape2D.set_deferred("disabled", false)
    $Area2D/CollisionShape2D.set_deferred("disabled", false)
    disabled = false
