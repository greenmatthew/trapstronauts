extends Node2D





func _on_Area2D_body_entered(body):
    if body is PlayerController:
        EventHandler.emit_signal("player_killed", body, get_parent())
