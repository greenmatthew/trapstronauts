class_name PlayerState
extends State

var player : PlayerController = null

func _ready() -> void:
    yield(owner, "ready")

    player = owner as PlayerController
    assert(player != null)

func physics_update(delta: float) -> void:
    if player.DEAD:
        state_machine.transition_to("Dead")
    physics_update_extension(delta)

func physics_update_extension(_delta: float) -> void:
    pass