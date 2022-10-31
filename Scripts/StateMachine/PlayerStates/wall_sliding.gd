extends PlayerState

func enter(_msg = {}):
    player.animator.play("slide")

func physics_update(delta : float) -> void:
    if player.forward.normalized() != player.direction:
        state_machine.transition_to("Falling")
        return
    
    if Input.is_action_just_pressed("jump"):
        state_machine.transition_to("Jumping", {normal = -player.forward + Vector2.UP})
        return

    if player.is_on_floor():
        if player.direction != Vector2.ZERO:
            state_machine.transition_to("Running")
            return
        else:
            state_machine.transition_to("Idle")
            return

    player.velocity.y += player.gravity * delta
    player.velocity.y = min(player.velocity.y, player.wall_slide_terminal_velocity)
    player.apply_velocity()
