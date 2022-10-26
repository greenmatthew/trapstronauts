extends Node2D

signal scene_changed(scene_name)

func _ready():
	$VBoxContainer/VBoxContainer/Start.grab_focus()
 
func _on_Start_pressed():
	emit_signal("scene_changed", "hub")
	print("Start Pressed")

func _on_Settings_pressed():
	print("Settings Pressed")

func _on_Credits_pressed():
	print("Credits Pressed")

func _on_Quit_pressed():
	get_tree().quit() 
	print("Quit Pressed")
