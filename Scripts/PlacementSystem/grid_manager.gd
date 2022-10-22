extends TileMap

const Util = preload("res://Scripts/Miscellaneous/util.gd")
var follow_mouse = preload("res://Scenes/PlacementSystem/follow_mouse.tscn")
var follow_controller = preload("res://Scenes/PlacementSystem/follow_controller.tscn")
onready var grid = $Grid
onready var placeable_selector = $Selector

var placing: Placeable
var is_placing: bool
var placeable_options

var placed_tiles: Dictionary

enum ObjectController { MOUSE, CONTROLLER }

func _ready():
    placeable_selector.connect("placeable_selected", self, "_on_placeable_selected")
    start_placeable_selection()
    # var obj_controller_instance = get_obj_controller_instance(ObjectController.MOUSE)
    # tile_instance.add_child(obj_controller_instance)
    # add_child(tile_instance)
 
func start_placeable_selection():
    is_placing = false
    placeable_selector.create_options()
    
func _on_placeable_selected(selection):
    placing = selection
    placing.get_parent().remove_child(placing)
    add_child(placing)
    is_placing = true
    placeable_selector.clear_options()

func _unhandled_input(event):
    if !is_placing:
        return

    if event.is_action_released("place_object"):
        if grid.can_place(placing, placing.xpos, placing.ypos):
            print("Placing")
            grid.add_shape_to_grid(placing)
            start_placeable_selection()
        else:
            print("Cannot place")

    elif event.is_action_released("rotate_clockwise"):
        placing.rotate_shape(Rotation.CLOCKWISE)
    elif event.is_action_released("rotate_counter_clockwise"):
        placing.rotate_shape(Rotation.COUNTER_CLOCKWISE)

func _process(_delta):
    if !is_placing:
        return

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
