extends Selector

onready var generator = $Generator
var placeable_options = []

func show_options():
    placeable_options.clear()

    for i in range(4):
        # TODO: figure out good spot to place them
        var placeable = generator.get_placeable()
        add_child(placeable)
        placeable.set_selecting(true)
        var viewport_size = get_viewport().get_visible_rect().size
        var y = viewport_size.y / 4 * i + 384
        placeable.set_position(Vector2(viewport_size.x / 2, y))
        placeable.connect("selected", self, "_on_placeable_selected")
        placeable_options.append(placeable)

func clear_options():
    for placeable in placeable_options:
        placeable.queue_free()

    placeable_options.clear()

func _on_placeable_selected(selection, player):
    placeable_options.erase(selection)
    emit_signal("placeable_selected", selection, player)
