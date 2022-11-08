extends KinematicBody2D


var speed  = 65
var motion = Vector2.ZERO
var player = null

func _physics_process(_delta):
    motion = Vector2.ZERO
    if player:
        motion = global_position.direction_to(player.position) * speed
    motion = move_and_slide(motion)
    for i in get_slide_count():
        var collision = get_slide_collision(i)
        if collision.collider.name == 'Player1':
            pass
            # print('Player got bombed')

func _on_Area2D_body_entered(body):
    if body.is_in_group("players"):
        player = body

func _on_Area2D_body_exited(body):
    # print('Player has exited')
    if body.is_in_group("players"):
        player = null
    
func disable() -> void:
    player = null
    $CollisionShape2D.set_deferred("disabled", true)
    $Area2D/CollisionShape2D.set_deferred("disabled", true)

func enable() -> void:
    $CollisionShape2D.set_deferred("disabled", false)
    $Area2D/CollisionShape2D.set_deferred("disabled", false)