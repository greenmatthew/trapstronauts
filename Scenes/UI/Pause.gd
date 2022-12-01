extends Control

func _on_Resume_pressed():
    get_tree().paused = false
    hide()

func _on_Exit_pressed():
    # EventHandler.emit_signal("scene_changed", "Pause", "MainMenu")
    get_tree().paused = false
    var _status = get_tree().change_scene("res://Scenes/Main.tscn")

func _unhandled_input(event):
    if event is InputEventKey and event.scancode == KEY_P and event.is_pressed():
        get_tree().paused = true
        show()
