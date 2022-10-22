extends Node


var placeables_scene = preload("res://Scenes/PlacementSystem/Placeables/placeables.tscn")
var placeables = []
var rng = RandomNumberGenerator.new()

func _ready():
    rng.randomize()

    var instance = placeables_scene.instance()
    add_child(instance)
    
    for placeable in instance.get_children():
        placeable.hide()
        placeables.append(placeable)
        

func get_placeable():
    var idx = rng.randi() % placeables.size()
    var placeable = placeables[idx]
    var dup = placeable.duplicate()

    dup.show()

    return dup 
