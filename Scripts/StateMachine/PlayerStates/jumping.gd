extends PlayerState

var just_jumped : bool = false

func enter(_msg = {}):
    player.animator.play("jump")
    player.myjump(_msg.get("normal"))
    just_jumped = true
    get_parent().get_parent().get_node("AudioStreamPlayer2").play()

func physics_update_extension(delta : float) -> void:
    if not just_jumped:
        get_parent().get_parent().get_node("AudioStreamPlayer").stop()
        if player.is_on_floor():
            state_machine.transition_to("Idle")
            return
        
        if player.is_on_wall():
            state_machine.transition_to("WallSliding", {wall_dir = player.direction()})
            return
    else:
        just_jumped = false
    
    
    if player.velocity.y > 0:
        state_machine.transition_to("Falling")
        return

    player.apply_velocity_not_grounded(delta)
