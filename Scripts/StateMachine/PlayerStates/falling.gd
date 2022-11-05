extends PlayerState

func enter(_msg = {}):
    player.animator.play("fall")

func exit() -> void:
    player.velocity.y = 0

func physics_update(delta : float) -> void:
    if player.is_on_floor():
        if player.direction != Vector2.ZERO:
            state_machine.transition_to("Running")
            return
        else:
            state_machine.transition_to("Idle")
            return
    
    if player.is_on_wall() and player.forward.normalized() == player.direction:
        state_machine.transition_to("WallSliding", {wall_dir = player.direction})
        return

    player.apply_velocity_not_grounded(delta)
