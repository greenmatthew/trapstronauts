extends Node2D

onready var parent = get_parent()

signal scene_changed(scene_name)

var input_maps = []
var players = []

func add_player(player_index):
    #print("Adding player {n}".format({"n":player_index}))
    var p = load("Scenes/Entities/Player.tscn")
    var player = p.instance()
    
    players.insert(player_index, player)
    
    parent.unpack_player(player_index)
    
    player.position = Vector2(0, 0)


var timer = 5
var departing = false
var time_since_tickdown = 0

func _ready():
    for i in range(parent.num_players):
        add_player(i)

func _process(delta):
    if departing:
        departing = departure_test()
        if not departing:
            timer = 5
        else:
            time_since_tickdown += delta
            if time_since_tickdown >= 1.0:
                timer -= 1
                time_since_tickdown = 0
                if timer == 0:
                    #Change this dynamically later, for now go to forest
                    emit_signal("scene_changed", "forest")
                    print("Scene change")
    else:
        departing = departure_test()
    $TimerTemp.set_text(str(timer))
    
func departure_test():
    return len($depart_trigger.get_overlapping_bodies()) - 1 >  parent.num_players / 2
