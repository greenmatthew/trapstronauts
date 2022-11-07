extends Node2D

signal scene_changed(scene_from, scene_to)

func add_player_to_world(player):
    add_child(player)
    var start = $Start
    print("start pos: ", start.position)
    var spawn_points = $Start/SpawnPoints.get_children()
    if spawn_points != null and spawn_points.size() > 0:
        var spawn_point = spawn_points[randi() % spawn_points.size()] 
        player.position = start.position + spawn_point.position + Vector2.UP * 0.5 * player.get_collider_height()
        print(player.global_position)
        player.rotation = spawn_point.rotation
    else:
        printerr("No spawn points found!")
    $MultiCam.add_target(player)

func _ready():
    pass
    # Add code to setup GridManager to size of the map
    #$GridManager/GridOutline.
