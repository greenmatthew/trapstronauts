extends Node2D

func _ready():
	$MultiCam.add_target($Player1)
	$MultiCam.add_target($TargetDummy)
	print("Added")
