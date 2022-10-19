extends Node2D

class_name Placeable

export (String, MULTILINE) var shape_def
# TODO: should not have to manually figure this out
export var place_offset: int

const local_coord_matrices = [[-1,1], [-1,0,1],[-2,-1,1,2]]

var shape: Array
var rotation_pivot
var bounding_square_size
var xpos = 0
var ypos = 0

func _ready():
	init_shape()
	print_shape()
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
