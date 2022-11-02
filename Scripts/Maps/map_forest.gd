extends Node2D

signal scene_changed(scene_from, scene_to)

func add_player_to_world(player):
    add_child(player)
    player.position = Vector2(50, 50)

func _ready():
    pass
    #$MultiCam.add_target($Player)
    #$MultiCam.add_target($TargetDummy)
    #print("Added")
