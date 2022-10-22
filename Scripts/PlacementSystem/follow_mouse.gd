extends Node2D

const Util = preload("res://Scripts/Miscellaneous/util.gd")

func _process(_delta):
    var cursor_position = get_global_mouse_position()
    self.get_parent().position = Util.pos_clamped_to_grid(cursor_position, Constants.GRID_SIZE)
        
