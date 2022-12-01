extends Node2D

export var txt = "Location"

onready var label = $Label

onready var pos = $Container

var supporters = []

var rect_size = 16

var padding = 2

func _ready():
    label.text = txt

func remove_player(player):
    pass

func add_player(player):
    supporters.append(player)

func clear_visuals():
    for n in pos.get_children():
        pos.remove_child(n)
        n.queue_free()

func draw_visual(color, index):
    
    var vis_rect = load("res://Scenes/UI/Score/ScoreRect.tscn").instance()
    var color_rect = vis_rect.get_child(1)
    var border = vis_rect.get_child(0)
    
    border.rect_position.x = pos.position.x + index * (rect_size + padding) - 1
    border.rect_position.y = border.rect_position.y + 1
    border.rect_size.x = rect_size + 2
    border.rect_size.y = rect_size + 2
    border.color = Color.black
    
    color_rect.rect_position.x = pos.position.x + index * (rect_size + padding)
    color_rect.rect_size.x = rect_size
    color_rect.rect_size.y = rect_size
    color_rect.color = color
    
    
    pos.add_child(vis_rect)

func draw_votes():
    clear_visuals()
    print(txt + str(len(supporters)))
    for i in range(len(supporters)):
        var s = supporters[i]
        draw_visual(s.charCol, i)
        
func update_votes(players):
    #print(len(players))
    for p in players:
        if supporters.has(p):
            if not p.current_vote == txt:
                remove_player(p) 
        else:
            if p.current_vote == txt:
                add_player(p)
    draw_votes()
