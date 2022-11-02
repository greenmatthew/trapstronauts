class_name StateMachine
extends Node

export var debug_state_display = NodePath();

signal transitioned(state_name)

export var initial_state := NodePath()

onready var state: State = get_node(initial_state)
onready var state_display: RichTextLabel = get_node(debug_state_display)

func _ready() -> void:
    yield(owner, "ready")
    for child in get_children():
        child.state_machine = self
    state_display.set_text(state.get_name())
    state.enter()

func _unhandled_input(event: InputEvent) -> void:
    state.handle_input(event)


func _process(delta: float) -> void:
    state.update(delta)


func _physics_process(delta: float) -> void:
    state.physics_update(delta)

func transition_to(target_state_name : String, msg : Dictionary = {}) -> void:
    if not has_node(target_state_name):
        printerr("State %s does not exist" % target_state_name)
        return

    state.exit()
    state = get_node(target_state_name)
    #print("Transitioned to %s" % target_state_name)
    state_display.set_text(state.get_name())
    state.enter(msg)
    emit_signal("transitioned", state.name)
