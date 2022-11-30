extends PlayerState

func enter(_msg = {}) -> void:
    player.animator.play("run")
    player.walking_trail.emitting = false
    player.sprinting_trail.emitting = true
    get_parent().get_parent().get_node("AudioStreamPlayer").play()

func exit() -> void:
    player.walking_trail.emitting = false
    player.sprinting_trail.emitting = false
    get_parent().get_parent().get_node("AudioStreamPlayer").stop()
    

func physics_update_extension(delta : float) -> void:
    if not player.is_on_floor():
        state_machine.transition_to("Falling")
        return
    
    if player.is_jumping():
        state_machine.transition_to("Jumping", {normal = Vector2.UP})
        return
    
    if player.direction() == Vector2.ZERO:
        state_machine.transition_to("Idle")
        return
    
    player.apply_velocity_grounded(delta)
