extends Node2D

func _ready():
	$MultiCam.add_target($Player)
	#$MultiCam.add_target($TargetDummy)
	#print("Added")
