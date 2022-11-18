extends Node2D

var offset = 96
var unit_length = 112

func add_rect(multiplier, color):
    
    var container = $BarContainer
    
    var score_rect = load("res://Scenes/UI/Score/ScoreRect.tscn").instance()
    var color_rect = score_rect.get_child(0)
    
    color_rect.rect_position.x = offset
    color_rect.rect_size.x = unit_length * multiplier
    color_rect.color = color
    
    offset = offset + color_rect.rect_size.x
    
    container.add_child(score_rect)
