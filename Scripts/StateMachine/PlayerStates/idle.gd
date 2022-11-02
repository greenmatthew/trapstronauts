extends PlayerState

func enter(_msg = {}):
    player.animator.play("idle")

func update(delta : float) -> void:
    if not player.is_on_floor():
        state_machine.transition_to("Falling")
        return
    
    if Input.is_action_pressed(player.ui_inputs.get("jump")):
        state_machine.transition_to("Jumping", {normal = Vector2.UP})
        return

    if Input.is_action_pressed(player.ui_inputs.get("right")) or Input.is_action_pressed(player.ui_inputs.get("left")):
        #print("INSIDE")
        state_machine.transition_to("Running")
        return

    player.apply_velocity_grounded(delta)
