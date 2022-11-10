extends Node2D

func _on_Area2D_body_entered(body):
    if body is PlayerController:
        EventHandler.emit_signal("player_killed", body, get_parent())

func disable() -> void:
    $Area2D/CollisionPolygon2D.set_deferred("disabled", true)

func enable() -> void:
    $Area2D/CollisionPolygon2D.set_deferred("disabled", false)
