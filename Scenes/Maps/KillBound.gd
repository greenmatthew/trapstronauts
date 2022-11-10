extends Area2D

func _on_MapKillBounds_body_entered(body):
    if body is PlayerController:
        EventHandler.emit_signal("player_killed", body)
