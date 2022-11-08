extends Area2D

var disabled: bool

func _physics_process(_delta):
    if disabled:
        return

    var bodies = get_overlapping_bodies()
    for body in bodies:
        if body.name =='Player':
            $AnimationPlayer.play("active-jumppad")
            yield($AnimationPlayer,"animation_finished")
            $AnimationPlayer.play("idle - jumppad")
        else:
            $AnimationPlayer.play("idle - jumppad")

func disable() -> void:
    disabled = true

func enable() -> void:
    disabled = false