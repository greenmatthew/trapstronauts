extends TileMap

const Util = preload("res://Scripts/Miscellaneous/util.gd")
var follow_mouse = preload("res://Scenes/PlacementSystem/follow_mouse.tscn")
var follow_controller = preload("res://Scenes/PlacementSystem/follow_controller.tscn")
onready var grid = $Grid
onready var grid_rect = $GridRect
onready var random_selector = $RandomSelector
onready var free_selector = $SelectorLayer/FreeSelector
var selector: Selector

var placing: Placeable
var is_placing: bool
var placeable_options
var amount_to_select

var placed_tiles: Dictionary

signal placeable_placed
signal placeable_selected

func _ready():
    # selector = free_selector if OS.is_debug_build() else random_selector
    selector = random_selector
    
    var _err = selector.connect("placeable_selected", self, "_on_placeable_selected")
    _err = EventHandler.connect("player_try_place", self, "_on_player_try_place")
    start_placeable_selection()
 
func set_amount_to_select(amount: int):
    assert(amount_to_select >= 1)
    amount_to_select = amount

func hide_selector_and_grid():
    selector.clear_options()
    grid_rect.hide()

func show_selector_and_grid():
    selector.show_options()
    grid_rect.show()

func hide_selector():
    selector.clear_options()

func hide_grid():
    grid_rect.hide()
 
func start_placeable_selection():
    is_placing = false
    selector.show_options()
    
func _on_placeable_selected(selection, player):
    placing = selection
    placing.get_parent().remove_child(placing)
    add_child(placing)
    placing.player = player
    is_placing = true
    emit_signal("placeable_selected", placing, player)

func _on_player_try_place(player, placeable, cursor_pos):
    clamp_placeable(placeable, cursor_pos)
    if grid.can_place(placeable, placeable.xpos, placeable.ypos):
        var fmt_str = "Placing at position: (%s, %s)"
        var actual_str = fmt_str % [placeable.xpos, placeable.ypos]
        print(actual_str)
        placeable.enable()
        grid.add_shape_to_grid(placeable)
        emit_signal("placeable_placed", placeable, player)
    else:
        print("Cannot place") 

func clamp_placeable(placeable, cursor_pos):
    var x = Vector2(cursor_pos.x - position.x, cursor_pos.y - position.y)
    var adjusted_cursor_pos = Vector2(cursor_pos.x - position.x - Constants.GRID_HALF_SIZE, cursor_pos.y - position.y - Constants.GRID_HALF_SIZE)
    var tile_map_pos = world_to_map(x)
    var pos_clamped = Util.pos_clamped_to_grid(adjusted_cursor_pos, Constants.GRID_SIZE)
    pos_clamped.x += Constants.GRID_HALF_SIZE
    pos_clamped.y += Constants.GRID_HALF_SIZE
    placeable.set_position(pos_clamped)
    placeable.xpos = tile_map_pos.x + placeable.place_offset
    placeable.ypos = tile_map_pos.y + placeable.place_offset
