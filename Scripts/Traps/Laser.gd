class_name Laser
extends StaticBody2D

onready var raycast = $RayCast2D

const direction : Vector2 = Vector2.RIGHT
const max_range : float = 1600.0

const duration : float = 1.5
var time : float = 0.0

var is_on : bool = false
var time_on : float = 0.0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    set_process(true)
    var _status = EventHandler.connect("timer", self, "on_timer_signal")
    raycast.enabled = true
    raycast.collide_with_bodies = true
    raycast.collide_with_areas = true
    if duration >= EventHandler.timer_interval:
        printerr("Duration of trap is longer than timer interval. This will cause the trap to permenantly be on.")

func _process(delta : float) -> void:
    update()
    if int(floor(time_on / duration)) >= 1:
        is_on = false
    time_on += delta

func _draw():
    if is_on:
        if raycast.is_colliding():
            draw_laser( abs(raycast.to_local(raycast.get_collision_point()).x) )
            var collider = raycast.get_collider()
            if collider is PlayerController:
                collider.death()
        else:
            draw_laser(max_range)

func on_timer_signal():
    is_on = true
    time_on = 0.0

func get_raycast_center() -> Vector2:
    return raycast.global_position

func get_raycast_relative_center() -> Vector2:
    return to_local(raycast.global_position)

func draw_laser(distance : float) -> void:
    var to = -direction * distance + get_raycast_relative_center()
    var from = get_raycast_relative_center()
    draw_line(from, to, Color.darkred, 4)
    draw_line(from, to, Color.red, 3)
    draw_line(from, to, Color.white, 2)