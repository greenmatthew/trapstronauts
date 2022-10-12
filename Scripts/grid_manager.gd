extends TileMap

const Util = preload("util.gd")
var follow_mouse = preload("res://Scenes/follow_mouse.tscn")
var follow_controller = preload("res://Scenes/follow_controller.tscn")
onready var generator = $Generator
onready var grid = $Grid

var placing

var placed_tiles: Dictionary

enum ObjectController { MOUSE, CONTROLLER }

func _ready():
    new_placeable()
    # var obj_controller_instance = get_obj_controller_instance(ObjectController.MOUSE)
    # tile_instance.add_child(obj_controller_instance)
    # add_child(tile_instance)
 
func new_placeable():
    placing = generator.get_placeable()
    add_child(placing)
    

func _unhandled_input(event):
    if event.is_action_released("place_object"):
        if grid.can_place(placing, placing.xpos, placing.ypos):
            print("Placing")
            grid.add_shape_to_grid(placing)
            placing = generator.get_placeable()
            new_placeable()
        else:
            print("Cannot place")

    elif event.is_action_released("rotate_clockwise"):
        placing.rotate_shape(Rotation.CLOCKWISE)
    elif event.is_action_released("rotate_counter_clockwise"):
        placing.rotate_shape(Rotation.COUNTER_CLOCKWISE)

func _process(_delta):
    var mouse_pos = get_global_mouse_position()
    var adjusted_mouse_pos = Vector2(mouse_pos.x - Constants.GRID_HALF_SIZE, mouse_pos.y - Constants.GRID_HALF_SIZE)
    
    var tile_map_pos = world_to_map(mouse_pos)
    # print("Tile idx: ", tile_map_pos)
    var pos_clamped = Util.pos_clamped_to_grid(adjusted_mouse_pos, Constants.GRID_SIZE)
    pos_clamped.x += Constants.GRID_HALF_SIZE
    pos_clamped.y += Constants.GRID_HALF_SIZE
    # print("mouse clamped: ", pos_clamped)
    placing.set_position(pos_clamped)
    placing.xpos = tile_map_pos.x
    placing.ypos = tile_map_pos.y
    # print(placing.xpos, " ", placing.ypos)
    placing.xpos += placing.place_offset
    placing.ypos += placing.place_offset

func get_obj_controller_instance(controller_type):
    var move_control_instance
    if controller_type == ObjectController.MOUSE:
        move_control_instance = follow_mouse.instance()
    else:
        move_control_instance = follow_controller.instance()
    
    move_control_instance.name = "ObjectMoveControl"
    return move_control_instance
