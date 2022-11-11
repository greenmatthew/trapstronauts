extends Node2D

signal scene_changed(scene_from, scene_to)

func _ready():
    $VBoxContainer/VBoxContainer/Start.grab_focus()

func _on_Start_pressed():
    print("Start Pressed")
    emit_signal("scene_changed", "MainMenu", "hub")

func _on_Settings_pressed():
    print("Settings Pressed")
    get_tree().change_scene("res://Scenes/UI/Settings.tscn")

func _on_Credits_pressed():
    print("Credits Pressed")
    get_tree().change_scene("res://Scenes/UI/Credits.tscn")

func _on_Quit_pressed():
    get_tree().quit() 
    print("Quit Pressed")
