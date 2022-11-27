extends Selector

onready var placeables = $Placeables

func _ready():
    for placeable in placeables.get_children():
        placeable.connect("selected", self, "_on_placeable_selected") 

func show_options() -> void:
    show()
    set_placeables_to_selecting()

func clear_options() -> void:
    hide()

func _on_placeable_selected(selection, _player):
    var dup = selection.duplicate()
    dup.set_position(Vector2.ZERO)
    add_child(dup)
    # TODO: shouldn't need to call unhighlight manually here
    dup.highlighter.unhighlight()
    emit_signal("placeable_selected", dup)

func set_placeables_to_selecting():
    for placeable in placeables.get_children():
       placeable.set_selecting(true)
