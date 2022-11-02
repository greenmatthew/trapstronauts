extends Node2D

onready var main = get_parent()

signal scene_changed(scene_from, scene_to)

var timer = 5
var departing = false
var time_since_tickdown = 0

func add_player_to_world(player):
    add_child(player)
    
    # TODO: Here, we will spawn the player in an empty bedroom. If none are available...
    # We'll figure something out
    player.position = Vector2(50, 50)

func _ready():
    pass

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
                    emit_signal("scene_changed", "hub", "forest")
                    print("Scene change")
    else:
        departing = departure_test()
    $TimerTemp.set_text(str(timer))
    
func departure_test():
    return len($depart_trigger.get_overlapping_bodies()) - 1 >  len(main.players) / 2
