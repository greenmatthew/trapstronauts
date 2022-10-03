extends TileMap


var placed_tiles: Dictionary

func _ready():
    print("Tile set ids: ", tile_set.get_tiles_ids())

    
func _unhandled_input(event):
    if event is InputEventMouseButton and event.button_index == 1:
        var mouse_pos = get_viewport().get_mouse_position()
        var tile_pos = world_to_map(mouse_pos)
        var tile_id = get_cell(tile_pos.x, tile_pos.y)
        print("Tile Pos: ", tile_pos)
        print("Tile Id: ", tile_id)
        
        if tile_id != -1 and !tile_pos in placed_tiles:
            pass
