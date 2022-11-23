extends PlayerState

func enter(_msg = {}):
    player.animator.play("dead")

func physics_update_extension(delta : float) -> void:
    if not player.DEAD:
        state_machine.transition_to("Idle")

    player.apply_velocity_not_grounded(delta)
