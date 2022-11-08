extends CollisionShape2D

func disable():
    set_deferred("disabled", true)

func enable():
    set_deferred("disabled", false)
