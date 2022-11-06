extends Area2D

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name =='Player':
			$AnimationPlayer.play("active-jumppad")
			yield($AnimationPlayer,"animation_finished")
			$AnimationPlayer.play("idle - jumppad")
		else:
			$AnimationPlayer.play("idle - jumppad")
			
