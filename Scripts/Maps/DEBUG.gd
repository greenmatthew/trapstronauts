extends Node2D

onready var grid_manager = $GridManager
var showing_selector = false

func _ready():
	$MultiCam.add_target($Player)
	grid_manager.hide_selector_and_grid()
	var _status = EventHandler.connect("player_killed", self, "_on_player_killed")
	#$MultiCam.add_target($TargetDummy)
	#print("Added")

func _on_player_killed(player: PlayerController, trap: Placeable):
	if (trap == null):
		print(player.name, " killed by unknown")
	else:
		print(player.name, " killed by ", trap.name)
	player.death()

func _unhandled_input(event):
	if event is InputEventKey and event.scancode == KEY_TAB and event.pressed:
		if showing_selector:
			grid_manager.hide_selector_and_grid()
			showing_selector = false
		else:
			grid_manager.show_selector_and_grid()
			showing_selector = true

