extends Node

func _ready():
	$VBoxContainer/VBoxContainer/Start.grab_focus()
 

func _on_Start_pressed():
	print("Start Pressed")

func _on_Settings_pressed():
	print("Settings Pressed")

func _on_Credits_pressed():
	print("Credits Pressed")

func _on_Quit_pressed():
	print("Quit Pressed")
