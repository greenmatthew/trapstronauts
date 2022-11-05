extends Area2D

class_name Highlighter

const Util = preload("res://Scripts/Miscellaneous/util.gd")

signal selected
var is_selecting: bool

func _ready():
    # warning-ignore:return_value_discarded
    connect("mouse_entered", self, "_on_mouse_entered")
    # warning-ignore:return_value_discarded
    connect("mouse_exited", self, "_on_mouse_exited")

func _on_mouse_entered():
    if is_selecting:
        highlight()

func _on_mouse_exited():
    if is_selecting:
        unhighlight()

func _input_event(_viewport, event, _shape_idx):
    # TODO: figure out more flexible input
    if is_selecting and event is InputEventMouseButton and event.button_index == 2:
        is_selecting = false
        emit_signal("selected")
        unhighlight()

func get_sprites():
    var sprites = []

    for node in Util.get_all_children(get_parent()):
        if node is Sprite:
            sprites.append(node)

    return sprites

func highlight():
    set_sprites_modulate(Color(1, 1.5, 1.5, 1))

func unhighlight():
    set_sprites_modulate(Color(1, 1, 1, 1))

func set_sprites_modulate(color):
    var sprites = get_sprites()

    for sprite in sprites:
        sprite.modulate = color
