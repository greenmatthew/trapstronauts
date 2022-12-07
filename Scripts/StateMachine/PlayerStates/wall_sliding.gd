extends PlayerState

var wall_dir : Vector2
var flag = false

func enter(_msg = {}):
    player.animator.play("slide")
    wall_dir = _msg.get("wall_dir")
    if not get_parent().get_parent().get_node("AudioStreamPlayer4").is_playing() and flag == false:
        get_parent().get_parent().get_node("AudioStreamPlayer4").play()
        flag = true
    

func physics_update_extension(delta : float) -> void:
    if not player.is_on_wall() || player.direction() != wall_dir:
        state_machine.transition_to("Falling")
        get_parent().get_parent().get_node("AudioStreamPlayer4").stop()
        flag = false
        return
    
    if player.is_jumping():
        state_machine.transition_to("Jumping", {normal = -player.direction() + Vector2.UP})
        get_parent().get_parent().get_node("AudioStreamPlayer4").stop()
        flag = false
        return

    if player.is_on_floor():
        if player.direction() != Vector2.ZERO:
            state_machine.transition_to("Running")
            get_parent().get_parent().get_node("AudioStreamPlayer4").stop()
            flag = false
            return
        else:
            state_machine.transition_to("Idle")
            get_parent().get_parent().get_node("AudioStreamPlayer4").stop()
            flag = false
            return

    player.velocity += 2 * wall_dir
    player.velocity.y += player.gravity * delta
    player.velocity.y = min(player.velocity.y, player.wall_slide_terminal_velocity)
    player.apply_velocity()
