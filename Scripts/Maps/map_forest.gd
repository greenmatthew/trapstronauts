extends Node2D

signal scene_changed(scene_from, scene_to)

onready var grid_manager = $GridManager 
var showing_selector = false

func add_player_to_world(player):
    add_child(player)
    var start = $Start
    var spawn_points = $Start/SpawnPoints.get_children()
    if spawn_points != null and spawn_points.size() > 0:
        var spawn_point = spawn_points[randi() % spawn_points.size()] 
        player.position = start.position + spawn_point.position + Vector2.UP * 0.5 * player.get_collider_height()
        player.rotation = spawn_point.rotation
    else:
        printerr("No spawn points found!")
    $MultiCam.add_target(player)

func _ready():
    init_grid()
    grid_manager.hide_selector_and_grid()

# based on the size of the grid_rect
func init_grid():
    grid_manager.grid.size = grid_manager.grid_rect.rect_size / 64
    grid_manager.grid.clear()

func _unhandled_input(event):
    if event is InputEventKey and event.scancode == KEY_TAB and event.pressed:
        if showing_selector:
            grid_manager.hide_selector_and_grid()
            showing_selector = false
        else:
            grid_manager.show_selector_and_grid()
            showing_selector = true
