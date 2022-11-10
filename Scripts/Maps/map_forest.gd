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
    connect_events()
    init_grid()
    grid_manager.hide_selector_and_grid()

func connect_events():
    var _status = EventHandler.connect("player_killed", self, "_on_player_killed")
    _status = EventHandler.connect("player_reached_finish", self, "_on_player_reached_finish")

# based on the size of the grid_rect
func init_grid():
    grid_manager.grid.size = grid_manager.grid_rect.rect_size / 64
    grid_manager.grid.clear()

func _on_player_killed(player: PlayerController, trap: Placeable = null):
    if trap != null:
        print("Player ", player.name, " killed by ", trap.name)
    player.death()

func _on_player_reached_finish(player: PlayerController):
    print("Player ", player.name, " reached finish")

func _unhandled_input(event):
    if event is InputEventKey and event.scancode == KEY_TAB and event.pressed:
        if showing_selector:
            grid_manager.hide_selector_and_grid()
            showing_selector = false
        else:
            grid_manager.show_selector_and_grid()
            showing_selector = true
