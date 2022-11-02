extends Node

var next_scene = null

onready var current_scene = $MainMenu
onready var anim = $AnimationPlayer

onready var num_players = 0

onready var on_menu = true

onready var player_cols = [
    Color.white,
    Color.orangered,
    Color.cornflower,
    Color.gold,
    Color.darkorchid,
    Color.forestgreen,
    Color.coral,
    Color.deeppink]

func unpack_player(player_index):
    
    var player = current_scene.players[player_index]
    
    player.set_color(player_cols[player_index])
    player.player_ID = player_index
    current_scene.add_child(player)
    
    map_controls(player_index)
    
func map_controls(player_index):
    
    current_scene.input_maps.insert(player_index, {
        "right" : "ui_right{n}".format({"n":player_index}),
        "left" : "ui_left{n}".format({"n":player_index}),
        "jump" : "ui_jump{n}".format({"n":player_index}),
        "sprint" : "ui_sprint{n}".format({"n":player_index})
    })
    
    current_scene.players[player_index].ui_inputs = current_scene.input_maps[player_index]
    
    var right_action: String
    var right_action_event: InputEventJoypadMotion

    var left_action: String
    var left_action_event: InputEventJoypadMotion
    
    var jump_action: String
    var jump_action_event: InputEventJoypadButton

    var sprint_action: String
    var sprint_action_event: InputEventJoypadButton

    right_action = "ui_right{n}".format({"n":player_index})
    InputMap.add_action(right_action)
    # Creat a new InputEvent instance to assign to the InputMap.
    right_action_event = InputEventJoypadMotion.new()
    right_action_event.device = player_index
    right_action_event.axis = JOY_AXIS_0 # <---- horizontal axis
    right_action_event.axis_value =  1.0 # <---- right
    InputMap.action_add_event(right_action, right_action_event)

    left_action = "ui_left{n}".format({"n":player_index})
    InputMap.add_action(left_action)
    # Creat a new InputEvent instance to assign to the InputMap.
    left_action_event = InputEventJoypadMotion.new()
    left_action_event.device = player_index
    left_action_event.axis = JOY_AXIS_0 # <---- horizontal axis
    left_action_event.axis_value = -1.0 # <---- left
    InputMap.action_add_event(left_action, left_action_event)

    jump_action = "ui_jump{n}".format({"n":player_index})
    InputMap.add_action(jump_action)
    
    jump_action_event = InputEventJoypadButton.new()
    jump_action_event.device = player_index
    jump_action_event.button_index = JOY_BUTTON_0
    jump_action_event.pressed = true
    InputMap.action_add_event(jump_action, jump_action_event)
    
    sprint_action = "ui_sprint{n}".format({"n":player_index})
    InputMap.add_action(sprint_action)
    
    sprint_action_event = InputEventJoypadButton.new()
    sprint_action_event.device = player_index
    sprint_action_event.button_index = JOY_BUTTON_2
    sprint_action_event.pressed = true
    InputMap.action_add_event(sprint_action, sprint_action_event)

func _on_joy_connection_changed(device, connected):
    if on_menu:
        return
    #print(device)
    if connected:
        num_players += 1
        current_scene.add_player(device)
    else:
        num_players -= 1
        current_scene.remove_player(device)

func _ready():
    current_scene.connect("scene_changed", self, "handle_scene_changed")
    Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

func handle_scene_changed(next_scene_name: String):
    
    var next
    
    num_players = len(Input.get_connected_joypads())
    
    on_menu = false
    
    match next_scene_name:
        "hub":
            next = load("res://Scenes/Maps/hub.tscn")
        "MainMenu":
            next = load("res://Scenes/UI/MainMenu/MainMenu.tscn")
            on_menu = true
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
