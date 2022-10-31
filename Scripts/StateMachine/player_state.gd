class_name PlayerState
extends State

var player : PlayerController = null

func _ready() -> void:
    yield(owner, "ready")

    player = owner as PlayerController
    assert(player != null)
