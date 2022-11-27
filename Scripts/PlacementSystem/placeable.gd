extends Node2D

class_name Placeable

const Util = preload("res://Scripts/Miscellaneous/util.gd")
onready var highlighter = $Highlighter

export (String, MULTILINE) var shape_def
export var place_offset: int = -1

const local_coord_matrices = [[-1,1], [-1,0,1],[-2,-1,1,2],[-2,-1,0,1,2]]

signal selected

var shape: Array
var rotation_pivot
var bounding_square_size
var xpos = 0
var ypos = 0

var player: PlayerController

func _ready():
    # warning-ignore:return_value_discarded
    highlighter.connect("selected", self, "_on_highlight_selected")
    _init_shape()
    bounding_square_size = int(max(shape.size(), shape[0].size()))
    rotation_pivot = Constants.GRID_SIZE * bounding_square_size / 2.0

    for child in get_children():
        if child.has_method("disable"):
            child.disable()

func disable():
    for child in get_children():
        if child.has_method("disable"):
            child.disable()

func enable():
    for child in get_children():
        if child.has_method("enable"):
            child.enable()

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

func _init_shape():
    assert(shape_def != "", "Shape def is empty")
    
    shape_def = shape_def.replace("\r", "")
    var lines = shape_def.split("\n")

    for line in lines:
        var row = []
        for ch in line:
            if ch != "x" and ch != "0":
                printerr("Bad Char in Shape def: (", ch, "), Ascii: ", ord(ch))
            else:
                row.append(ch == "x")
        shape.append(row)

func set_selecting(is_selecting: bool):
    highlighter.is_selecting = is_selecting


# warning-ignore:shadowed_variable
func _on_highlight_selected(player):
    emit_signal("selected", self, player)
