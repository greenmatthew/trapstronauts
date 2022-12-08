extends Node2D
onready var timer = get_node("Timer")
onready var timer2 = get_node("Timer2")







func _on_Area2D_body_entered(body):
    if body is PlayerController:
        timer.set_wait_time(0.8)
        timer.start()


func _on_Timer_timeout():
    $KinematicBody2D/Sprite.visible = false
    $KinematicBody2D/CollisionShape2D.disabled = true
    timer2.set_wait_time(1.5)
    timer2.start()
    timer.stop()
    


func _on_Timer2_timeout():
    $KinematicBody2D/Sprite.visible = true
    $KinematicBody2D/CollisionShape2D.disabled = false
    timer2.stop()
