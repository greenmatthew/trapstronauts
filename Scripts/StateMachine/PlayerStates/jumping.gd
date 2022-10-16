extends PlayerState

var just_jumped : bool = false

func enter(_msg = {}):
    player.animator.play("jump")
    player.myjump(_msg.get("normal"))
    just_jumped = true

func physics_update(delta : float) -> void:
    if not just_jumped:
        if player.is_on_floor():
            state_machine.transition_to("Idle")
            return
        
        if player.is_on_wall() and player.forward.normalized() == player.direction:
            state_machine.transition_to("WallSliding")
            return
    else:
        just_jumped = false
    
    
    if player.velocity.y > 0:
        state_machine.transition_to("Falling")
        return

    player.apply_velocity_not_grounded(delta)
