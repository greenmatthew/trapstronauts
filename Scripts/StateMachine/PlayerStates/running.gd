extends PlayerState

func enter(_msg = {}) -> void:
	print("Start Running")
	player.animator.play("run")
	player.walking_trail.emitting = false
	player.sprinting_trail.emitting = true

func exit() -> void:
	player.walking_trail.emitting = false
	player.sprinting_trail.emitting = false

func physics_update(delta : float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Falling")
		return
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jumping", {normal = Vector2.UP})
		return
	
	if player.direction == Vector2.ZERO:
		state_machine.transition_to("Idle")
		return
	
	player.apply_velocity_grounded(delta)
