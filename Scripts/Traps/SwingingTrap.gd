extends Node2D

func _ready():
    $AnimationPlayer.play("swingTrap")

func _on_SwingingTrap_body_entered(body):
    if body is PlayerController:
        EventHandler.emit_signal("player_killed", body, get_parent())
        
func disable() -> void:
    $CollisionPolygon2D.disabled = true
    $AnimationPlayer.stop()

func enable() -> void:
    $CollisionPolygon2D.disabled = false
    $AnimationPlayer.play("swingTrap")
