extends Area2D

func _ready():
	$AnimationPlayer.play("swingTrap")
	

func _on_SwingingTrap_body_entered(body):
	if body is PlayerController:
		get_tree().reload_current_scene()
		
