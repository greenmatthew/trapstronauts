extends Node2D

var size = Vector2(16, 16)

var grid: Array

func _ready():
	clear()

func clear():
	grid = []
	grid.resize(size.x * size.y)

func can_place(placeable, xo, yo) -> bool:
	for y in placeable.bounding_square_size:
		for x in placeable.bounding_square_size:
			if placeable.shape[y][x]: # Tile exists
				if x + xo < 0 or x + xo >= size.x: # Off side of grid
					return false
				if y + yo < 0 or y + yo >= size.y: # Off bottom of grid
					return false
				var idx = x + xo + (y + yo) * size.x
				if idx >= 0 and grid[idx]:
					return false # Occupied cell
	return true


func add_shape_to_grid(shape: Placeable):
	for y in shape.bounding_square_size:
		for x in shape.bounding_square_size:
			if shape.shape[y][x]:
				var idx = x + shape.xpos + (y + shape.ypos) * size.x
				assert(idx >= 0)
				grid[idx] = true
