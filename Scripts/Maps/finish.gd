extends Area2D

onready var player_count = 0

func _on_Area2D_body_entered(body: Node):
    if body is PlayerController:
        player_count += 1
        EventHandler.emit_signal("player_reached_finish", body)
