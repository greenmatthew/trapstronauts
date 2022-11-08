extends Area2D

func _on_Area2D_body_entered(body: Node):
    if body is PlayerController:
        EventHandler.emit_signal("player_reached_finish", body)
