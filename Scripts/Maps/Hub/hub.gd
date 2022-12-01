extends Node2D

onready var main = get_parent()

onready var trigger = $warproom/depart_trigger
onready var timer_label = $warproom/depart_trigger/TimerTemp

onready var voting_room = $votingroom

onready var candidates = $votingroom/Candidates

var timer = 5
var departing = false
var time_since_tickdown = 0

var players_added = 0

func handle_vote(player):
    for c in candidates.get_children():
        for body in c.get_child(2).get_overlapping_bodies():
            if body == player:
                player.current_vote = c.txt
        c.update_votes(main.players)
    
func _input(_event):
    for i in range(len(main.players)):
        var cID = i - 1
        if i == 0 and Input.is_key_pressed(KEY_W):
            handle_vote(main.players[i])
        if i != 0 and Input.is_action_pressed("ui_up" + str(cID)):
            handle_vote(main.players[i])

func add_player_to_world(player):
    add_child(player)
    
    $MultiCam.add_target(player)
    
    # TODO: Here, we will spawn the player in an empty bedroom. If none are available...
    # We'll figure something out
    
    player.reset()
    
    player.position = get_node("Bedroom{n}".format({"n":players_added})).position
    
    players_added += 1

func _ready():
    for c in candidates.get_children():
        c.update_votes(main.players)

func next_map():
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var index = rng.randi_range(0, len(main.players) - 1)
    var selection = main.players[index].current_vote
    
    if selection == "Random":
        var maps = ["Forest", "Sawmill", "Cliffs", "Valley"]
        rng.randomize()
        selection = maps[rng.randi_range(0, len(maps) - 1)]
    
    EventHandler.emit_signal("scene_changed", "hub", selection)

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
                    # TODO: Change this dynamically later, for now go to forest
                    next_map()
    else:
        departing = departure_test()
    timer_label.set_text(str(timer))
    
func departure_test():
    # warning-ignore:integer_division
    return len(trigger.get_overlapping_bodies()) - 1 >  len(main.players) / 2
