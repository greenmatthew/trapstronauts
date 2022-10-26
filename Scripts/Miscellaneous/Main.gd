extends Node

var next_scene = null

onready var current_scene = $MainMenu
onready var anim = $AnimationPlayer

onready var NUM_PLAYERS = 0

onready var PLAYERS = []

func add_player():
	var p
	if NUM_PLAYERS == 0:
		p = load("res://Scenes/Entities/Player.tscn")
	NUM_PLAYERS += 1
	PLAYERS.append(p)

func remove_player(index):
	PLAYERS.pop_at(index).queue_free()

func _ready():
	current_scene.connect("scene_changed", self, "handle_scene_changed")

func handle_scene_changed(next_scene_name: String):
	
	var next
	
	match next_scene_name:
		"hub":
			next = load("res://Scenes/Maps/hub.tscn")
		"MainMenu":
			next = load("res://Scenes/UI/MainMenu/MainMenu.tscn")
		"forest":
			next = load("res://Scenes/Maps/map_forest.tscn")
		_:
			return
		
	next_scene = next.instance()
	hide_all(next_scene)
	
	add_child(next_scene)
	anim.play("fade_in")
	
	next_scene.connect("scene_changed", self, "handle_scene_changed")

func hide_all(node):
	node.visible = false
	for child in node.get_children():
		child.visible = false
	
func reveal_all(node):
	node.visible = true
	for child in node.get_children():
		child.visible = true

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"fade_in":
				current_scene.queue_free()
				current_scene = next_scene
				reveal_all(next_scene)
				next_scene = null
				anim.play("fade_out")
