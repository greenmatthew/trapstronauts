extends Node2D

onready var main = get_parent()

onready var trigger = $warproom/depart_trigger
onready var timer_label = $warproom/depart_trigger/TimerTemp


signal scene_changed(scene_from, scene_to)

var timer = 5
var departing = false
var time_since_tickdown = 0

var players_added = 0

func add_player_to_world(player):
    add_child(player)
    
    $MultiCam.add_target(player)
    
    # TODO: Here, we will spawn the player in an empty bedroom. If none are available...
    # We'll figure something out
    player.position = get_node("Bedroom{n}".format({"n":players_added})).position
    
    players_added += 1

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
                    emit_signal("scene_changed", "hub", "sawmill")
                    print("Scene change")
    else:
        departing = departure_test()
    timer_label.set_text(str(timer))
    
func departure_test():
    # warning-ignore:integer_division
    return len(trigger.get_overlapping_bodies()) - 1 >  len(main.players) / 2
