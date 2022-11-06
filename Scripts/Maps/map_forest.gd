extends Node2D

signal scene_changed(scene_from, scene_to)

func add_player_to_world(player):
    add_child(player)
    var spawn_points = $Start.get_children()
    if spawn_points != null and spawn_points.size() > 0:
        var spawn_point = spawn_points[randi() % spawn_points.size()] 
        player.global_position = spawn_point.global_position - Vector2.RIGHT * 0.5 * player.get_collider_height()
        player.rotation = spawn_point.rotation
    else:
        printerr("No spawn points found!")
    $MultiCam.add_target(player)

func _ready():
    pass
    #$MultiCam.add_target($Player)
    #$MultiCam.add_target($TargetDummy)
    #print("Added")
