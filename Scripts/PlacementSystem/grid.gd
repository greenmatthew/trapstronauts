extends Node2D

export var size = Vector2(16, 16)

var grid: Array
onready var map_occupied_space: Placeable = $MapTileSpace

func _ready():
    clear()

func clear():
    grid = []
    grid.resize(size.x * size.y)

func add_non_placeable_location(idx):
    grid[idx.x + idx.y * size.x] = map_occupied_space

func can_place(placeable, xo, yo) -> bool:
    for y in placeable.bounding_square_size:
        for x in placeable.bounding_square_size:
            if placeable.shape[y][x]: # Tile exists
                if x + xo < 0 or x + xo >= size.x: # Off side of grid
                    return false
                if y + yo < 0 or y + yo >= size.y: # Off bottom of grid
                    return false
                var idx = x + xo + (y + yo) * size.x
                if idx >= 0 and grid[idx] != null and !placeable.is_bomb:
                    return false # Occupied cell
    return true


func add_shape_to_grid(shape: Placeable):
    for y in shape.bounding_square_size:
        for x in shape.bounding_square_size:
            if shape.shape[y][x]:
                var idx = x + shape.xpos + (y + shape.ypos) * size.x
                assert(idx >= 0)
                grid[idx] = shape

# Should call can_place before place_bomb
func place_bomb(bomb: Placeable, xo, yo):
    # for each overlapping tile
    # blow up placeable there if present
    
    for y in bomb.bounding_square_size:
        for x in bomb.bounding_square_size:
            if bomb.shape[y][x]: # Tile exists
                assert(!(x + xo < 0 or x + xo >= size.x)) # Off side of grid
                assert(!(y + yo < 0 or y + yo >= size.y)) # Off bottom of grid
                
                var idx = x + xo + (y + yo) * size.x
                if idx >= 0 and grid[idx] != null and grid[idx] != map_occupied_space: # Cell occupied by other placeable
                    var placeable = grid[idx]
                    # remove all references to it left in grid
                    for i in grid.size():
                            if grid[i] == placeable:
                                grid[i] = null
                    # delete placeable
                    print("Deleting placeable ", placeable)
                    placeable.queue_free()
                            
