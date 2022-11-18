extends Node2D

signal scene_changed(scene_from, scene_to)

onready var main = get_parent()
onready var grid_manager = $GridManager 
onready var finish = $Finish/Area2D
onready var score_screen = $ScoreScreen

var showing_selector = false

var first_player = true

var used_spawns = []

func next_round():
    first_player = true
    for p in main.players:
        p.reset()
        spawn_player(p)

func go_to_score_screen():
    score_screen.show_score(finish.player_count)

func add_player_to_world(player):
    add_child(player)
    spawn_player(player)
    
    $MultiCam.add_target(player)   

func _ready():
    connect_events()
    init_grid()
    grid_manager.hide_selector_and_grid()
    score_screen.hide_score()

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
    if all_players_finished():
        go_to_score_screen()

func _on_player_reached_finish(player: PlayerController):
    player.GOAL = true
    if first_player:
        first_player = false
        player.FRST = true
    if all_players_finished():
        go_to_score_screen()

func all_players_finished():
    var finished = true
    for p in main.players:
        finished = finished and (p.DEAD or p.GOAL)
    return finished

func _unhandled_input(event):
    if event is InputEventKey and event.scancode == KEY_TAB and event.pressed:
        if showing_selector:
            grid_manager.hide_selector_and_grid()
            showing_selector = false
        else:
            grid_manager.show_selector_and_grid()
            showing_selector = true

func spawn_player(player: PlayerController):
    var start = $Start
    var spawn_points = $Start/SpawnPoints.get_children()
    
    var spawn_index = 0
    while used_spawns.has(spawn_index):
        spawn_index = randi() % spawn_points.size()
    
    used_spawns.append(spawn_index)
    
    if spawn_points != null and spawn_points.size() > 0:
        var spawn_point = spawn_points[spawn_index] 
        player.position = start.position + spawn_point.position + Vector2.UP * 0.5 * player.get_collider_height()
        player.rotation = spawn_point.rotation
    else:
        printerr("No spawn points found!")
