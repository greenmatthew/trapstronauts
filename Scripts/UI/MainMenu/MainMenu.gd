extends Node2D

func _ready():
	$VBoxContainer/VBoxContainer/Start.grab_focus()

func _on_Start_pressed():
	print("Start Pressed")
	EventHandler.emit_signal("scene_changed", "MainMenu", "hub")

func _on_Settings_pressed():
	print("Settings Pressed")
	var status = get_tree().change_scene("res://Scenes/UI/Settings.tscn")
	assert(status == OK)

func _on_Credits_pressed():
	print("Credits Pressed")
	var status = get_tree().change_scene("res://Scenes/UI/Credits.tscn")
	assert(status == OK)

func _on_Quit_pressed():
	get_tree().quit() 
	print("Quit Pressed")
