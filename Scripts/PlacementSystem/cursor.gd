extends Node2D

export var speed: float = 64
var follow_mouse: bool

func _process(_delta):
    if follow_mouse:
        set_global_position(get_global_mouse_position())

func set_color(color: Color):
    $Sprite.modulate = color
