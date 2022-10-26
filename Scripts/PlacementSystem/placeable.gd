extends Area2D

class_name Placeable

const Util = preload("res://Scripts/Miscellaneous/util.gd")

export (String, MULTILINE) var shape_def
var place_offset: int = -1

const local_coord_matrices = [[-1,1], [-1,0,1],[-2,-1,1,2]]

signal selected
var is_selecting: bool

var shape: Array
var rotation_pivot
var bounding_square_size
var xpos = 0
var ypos = 0

func _ready():
    # warning-ignore:return_value_discarded
    connect("mouse_entered", self, "_on_mouse_entered")
    # warning-ignore:return_value_discarded
    connect("mouse_exited", self, "_on_mouse_exited")
    init_shape()
    # print_shape()
    bounding_square_size = int(max(shape.size(), shape[0].size()))
    rotation_pivot = Constants.GRID_SIZE * bounding_square_size / 2.0

func print_shape():
    for row in shape:
        print(row, "\n")

func rotate_shape(rotation):
    var rot_mat = local_coord_matrices[bounding_square_size - 2]
    var rotated_shape = shape.duplicate(true)

    if rotation == Rotation.COUNTER_CLOCKWISE:
        for y in bounding_square_size:
            var xx = rot_mat.find(-rot_mat[y])
            for x in bounding_square_size:
                rotated_shape[y][x] = shape[x][xx]
        rotate(-PI / 2)
    else:
        for x in bounding_square_size:
            var yy = rot_mat.find(-rot_mat[x])
            for y in bounding_square_size:
                rotated_shape[y][x] = shape[yy][y]
        rotate(PI / 2)
    shape = rotated_shape

func init_shape():
    var lines = shape_def.split("\n")

    for line in lines:
        var row = []
        for ch in line:
            row.append(ch == "x")
        shape.append(row)

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
        emit_signal("selected", self)
        unhighlight()
        

func get_sprites():
    var sprites = []

    for node in Util.get_all_children(self):
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
