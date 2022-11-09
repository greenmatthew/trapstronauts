extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimationPlayer.play("SpikeDude_move")

func _process(delta):
    $Spikedude_path/Spikedude_PathFollow2D.offset += 55 * delta

func _on_Area2D_body_entered(body):
    if body is PlayerController:
        EventHandler.emit_signal("player_killed", body, get_parent())
