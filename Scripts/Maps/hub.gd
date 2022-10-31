extends Node2D

signal scene_changed(scene_name)

var num_players = 0

func add_player(player_index):
    pass
    
func remove_player(player_index):
    pass

var timer = 5
var departing = false
var time_since_tickdown = 0

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
                    emit_signal("scene_changed", "forest")
                    print("Scene change")
    else:
        departing = departure_test()
    $TimerTemp.set_text(str(timer))
    
func departure_test():
    print(len($depart_trigger.get_overlapping_areas()))
    return len($depart_trigger.get_overlapping_bodies()) - 1 >  manager.NUM_PLAYERS/ 2
