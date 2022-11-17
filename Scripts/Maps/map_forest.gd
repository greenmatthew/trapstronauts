extends Node2D

signal scene_changed(scene_from, scene_to)

onready var main = get_parent()
onready var grid_manager = $GridManager 
onready var finish = $Finish/Area2D

var showing_selector = false

var first = true

func add_player_to_world(player):
    add_child(player)
    spawn_player(player)
    
    $MultiCam.add_target(player)

func _process(delta):
    if all_players_finished():
        if finish.player_count == 0:
            pass
            #Special case where every player died
        elif finish.player_count == 1:
            for p in main.players:
                if p.in_goal:
                    p.score += main.SCORE_VALUES.GOAL_REACHED_SOLO_BONUS
        elif finish.player_count == len(main.players):
            pass
            #special case where every player finished - NO points are awarded
            
        # SHOW SCORE SCREEN HERE
        print("All players are dead or have finished. Here are the scores: ")
        
        # Reset all players for the next round
        for p in main.players:
            print(p.score)
            spawn_player(p)
            p.new_round()
        

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
    if player.in_goal:
        player.score += main.SCORE_VALUES.GOAL_REACHED_DEAD
    else:
        player.score += 0

func _on_player_reached_finish(player: PlayerController):
    player.in_goal = true
    if player.is_dead:
        player.score += main.SCORE_VALUES.GOAL_REACHED_DEAD
    else:
        player.score += main.SCORE_VALUES.GOAL_REACHED_ALIVE
    if first:
        first = false
        player.score += main.SCORE_VALUES.GOAL_REACHED_FIRST_BONUS
    print("Player ", player.name, " reached finish")

func all_players_finished():
    var finished = true
    for p in main.players:
        finished = finished and (p.is_dead or p.in_goal)
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
    if spawn_points != null and spawn_points.size() > 0:
        var spawn_point = spawn_points[randi() % spawn_points.size()] 
        player.position = start.position + spawn_point.position + Vector2.UP * 0.5 * player.get_collider_height()
        player.rotation = spawn_point.rotation
    else:
        printerr("No spawn points found!")
