extends Area2D

var disabled: bool

func _physics_process(_delta):
    if disabled:
        return

    var bodies = get_overlapping_bodies()
    for body in bodies:
        if body is PlayerController:
            body.handle_jump_pad_jump()
            $AnimationPlayer.play("active-jumppad")
            $AudioStreamPlayer.play()
            yield($AnimationPlayer,"animation_finished")
            $AnimationPlayer.play("idle - jumppad")
        else:
            $AudioStreamPlayer.stop()
            $AnimationPlayer.play("idle - jumppad")

func disable() -> void:
    disabled = true

func enable() -> void:
    disabled = false
