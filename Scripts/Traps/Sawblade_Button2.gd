extends Node2D
var player_up = null
var count_up = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimationPlayer.play("When_it_is_not_clicked")
func check_if_its_already_pressed(x):
    if x == 1:
        $AnimationPlayer.play("When_it_is_clicked")
        get_parent().get_node("RollingSawBlade2").follow_speed = 750
        get_parent().get_node("RollingSawBlade3").follow_speed = 750
        $AudioStreamPlayer.play()
    if x == 0:
        $AnimationPlayer.play("When_it_is_not_clicked")
        get_parent().get_node("RollingSawBlade2").follow_speed = 250
        get_parent().get_node("RollingSawBlade3").follow_speed = 250
        $AudioStreamPlayer.stop()
    
func _physics_process(_delta):
    if player_up:
        count_up = count_up + 1
        check_if_its_already_pressed(count_up)
    elif player_up == null:
        count_up = 0
        check_if_its_already_pressed(count_up)


func _on_Area2D_body_entered(body):
    if body.is_in_group("players"):
        player_up = body


func _on_Area2D_body_exited(body):
    if body.is_in_group("players"):
        player_up = null
