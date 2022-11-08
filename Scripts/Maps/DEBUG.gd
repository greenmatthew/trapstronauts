extends Node2D

onready var grid_manager = $GridManager
var showing_selector = false

func _ready():
    $MultiCam.add_target($Player)
    grid_manager.hide_selector_and_grid()
    #$MultiCam.add_target($TargetDummy)
    #print("Added")

func _unhandled_input(event):
    if event is InputEventKey and event.scancode == KEY_TAB and event.pressed:
        if showing_selector:
            grid_manager.hide_selector_and_grid()
            showing_selector = false
        else:
            grid_manager.show_selector_and_grid()
            showing_selector = true

