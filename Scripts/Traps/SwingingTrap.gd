extends Node2D

func _ready():
    $AnimationPlayer.play("swingTrap")

func _on_SwingingTrap_body_entered(body):
    if body is PlayerController:
        var _godot_is_trash = get_tree().reload_current_scene()
        
