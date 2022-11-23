extends PlayerState

func enter(_msg = {}):
    player.animator.play("idle")

func physics_update_extension(delta : float) -> void:
    if player.DEAD:
        state_machine.transition_to("Dead")

    if not player.is_on_floor():
        state_machine.transition_to("Falling")
        return
    
    if player.is_jumping():
        state_machine.transition_to("Jumping", {normal = Vector2.UP})
        return

    if player.direction() != Vector2.ZERO:
        state_machine.transition_to("Running")
        return

    player.apply_velocity_grounded(delta)
