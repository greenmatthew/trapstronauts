extends Area2D

class_name Highlighter

const Util = preload("res://Scripts/Miscellaneous/util.gd")

signal selected
var is_selecting: bool
onready var shape2d = $CollisionShape2D

func _ready():
    # warning-ignore:return_value_discarded
    connect("mouse_entered", self, "_on_mouse_entered")
    # warning-ignore:return_value_discarded
    connect("mouse_exited", self, "_on_mouse_exited")
    var _status = EventHandler.connect("player_select_input", self, "_on_player_select_input")

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
        emit_signal("selected",  get_tree().get_root().get_node("Main").players[0])
        unhighlight()

func has_point(cursor_pos: Vector2) -> bool:
    var extents = shape2d.shape.extents
    var rect = Rect2(global_position - extents, extents * 2.0)
    
    return rect.has_point(cursor_pos)

func _on_player_select_input(player, cursor_pos):
    if has_point(cursor_pos):
        emit_signal("selected", player)

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
