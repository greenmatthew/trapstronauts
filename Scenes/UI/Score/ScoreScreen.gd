extends CanvasLayer

onready var main = get_node("/root/Main")
onready var canvas = $Control/Canvas
onready var control = $Control

onready var text = $Control/Label

onready var level = get_parent()

onready var margin = 216
onready var showing = false

onready var max_score = 5.0

onready var num_players = len(main.players)

onready var winners = []

onready var score_dict = {
    "Reached Goal" : 1.0,
    "Postmortem" : 0.4,
    "Solo" : 0.6,
    "First" : 0.2
    #"Trap Kill" : 0.2
   }
onready var color_dict = {
    "Reached Goal" : Color.green,
    "Postmortem" : Color.purple,
    "Solo" : Color.yellow,
    "First" : Color.orange
    #"Trap Kill" : Color.red
   }

func game_over():
    for p in main.players:
        if p.score_total >= max_score:
            winners.append(p)
    if len(winners) > 0:
        return true
    return false 
    
func go_to_finish():
    level.end_level()

func _input(_ev):
    if showing:
        if Input.is_key_pressed(KEY_SPACE):
            if game_over():
                go_to_finish()
            level.next_round()
            hide_score()

func _ready():
    for i in range(num_players):
        var new_score_UI = load("res://Scenes/UI/Score/ScoreUI.tscn").instance()
        new_score_UI.position.x = margin
        new_score_UI.position.y = canvas.rect_size.y / (num_players + 1) * (i + 1)
        new_score_UI.set_p_color(main.players[i].charCol)
        canvas.add_child(new_score_UI)

func show_type(type, num_winners):
    
    text.add_color_override("font_color", color_dict[type])
    text.text = type
    
    for i in range(len(main.players)):
        var p = main.players[i]
        match type:
            "Reached Goal":
                if p.GOAL and not p.DEAD:
                    canvas.get_child(i).add_rect(score_dict[type], color_dict[type])
                    p.score_total += score_dict[type]
            "Postmortem":
                if p.GOAL and p.DEAD:
                    canvas.get_child(i).add_rect(score_dict[type], color_dict[type])
                    p.score_total += score_dict[type]
            "Solo":
                if num_winners == 1 and p.GOAL:
                    canvas.get_child(i).add_rect(score_dict[type], color_dict[type])
                    p.score_total += score_dict[type]
            "First":
                if p.GOAL and p.FRST:
                    canvas.get_child(i).add_rect(score_dict[type], color_dict[type])
                    p.score_total += score_dict[type]
            _ : pass
            

func show_score(count):
    #if count != num_players and count != 0:
    text.text = ""
    control.show()
    for key in score_dict:
        yield(get_tree().create_timer(1), "timeout")
        show_type(key, count)
    yield(get_tree().create_timer(1), "timeout")
    text.add_color_override("font_color", Color.black)
    text.text = "Press space to continue..."
    showing = true

func hide_score():
    control.hide()
    showing = false
