extends Node2D
onready var timer = get_node("Timer")
onready var timer2 = get_node("Timer2")

func _ready():
    $AnimationPlayer.play("movingplatform_flying")

func _process(delta):
    $movingplatform_path2d/movingplatform_follow2d.offset += 55 * delta





func _on_Area2D_body_entered(body):
    if body is PlayerController:
        timer.set_wait_time(2.7)
        timer.start()


func _on_Timer_timeout():
    $movingplatform_path2d/movingplatform_follow2d/Sprite.visible=false
    $movingplatform_path2d/movingplatform_follow2d/KinematicBody2D/CollisionShape2D.disabled= true
    timer2.set_wait_time(1.5)
    timer2.start()
    timer.stop()
    


func _on_Timer2_timeout():
    $movingplatform_path2d/movingplatform_follow2d/Sprite.visible=true
    $movingplatform_path2d/movingplatform_follow2d/KinematicBody2D/CollisionShape2D.disabled= false
    timer2.stop()
