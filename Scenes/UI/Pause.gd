extends Control

signal resume

func _on_Resume_pressed():
    emit_signal("resume")

func _on_Exit_pressed():
    var _status = get_tree().change_scene("res://Scenes/Main.tscn")
