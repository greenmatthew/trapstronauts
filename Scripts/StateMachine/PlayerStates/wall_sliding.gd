extends PlayerState

var wall_dir : Vector2

func enter(_msg = {}):
    player.animator.play("slide")
    wall_dir = _msg.get("wall_dir")

func physics_update(delta : float) -> void:
    if not player.is_on_wall() || player.direction != wall_dir:
        state_machine.transition_to("Falling")
        return
    
    if Input.is_action_just_pressed(player.ui_inputs.get("jump")):
        state_machine.transition_to("Jumping", {normal = -player.forward + Vector2.UP})
        return

    if player.is_on_floor():
        if player.direction != Vector2.ZERO:
            state_machine.transition_to("Running")
            return
        else:
            state_machine.transition_to("Idle")
            return

    player.velocity += 2 * wall_dir
    player.velocity.y += player.gravity * delta
    player.velocity.y = min(player.velocity.y, player.wall_slide_terminal_velocity)
    player.apply_velocity()
