extends Node

const Util = preload("res://Scripts/Miscellaneous/util.gd")
export var cursor_speed: float

var cursor_position: Vector2
        
func _ready():
    cursor_position = self.get_parent().position
        
func _physics_process(delta):
    var input_vector = Input.get_vector("move_obj_left", "move_obj_right", "move_obj_up", "move_obj_down")
    var move_delta = input_vector * cursor_speed * delta
    cursor_position += move_delta
    var parent = self.get_parent()
    parent.position = Util.pos_clamped_to_grid(cursor_position, Constants.GRID_SIZE)
