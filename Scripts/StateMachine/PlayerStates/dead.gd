extends PlayerState
var flag = false
func enter(_msg = {}):
	player.animator.play("dead")
	if not get_parent().get_parent().get_node("AudioStreamPlayer3").is_playing() and flag == false:
		get_parent().get_parent().get_node("AudioStreamPlayer3").play()
		flag = true
		
		
		

func physics_update_extension(delta : float) -> void:
	if not player.DEAD:
		state_machine.transition_to("Idle")
		get_parent().get_parent().get_node("AudioStreamPlayer3").stop()
		flag = false
	player.apply_velocity_not_grounded(delta)
