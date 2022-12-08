extends Node

var next_scene
onready var current_scene = $MainMenu
onready var anim = $AnimationPlayer

onready var ON_MENU = true

onready var player_cols = [
    Color.white,
    Color.orangered,
    Color.cornflower,
    Color.gold,
    Color.darkorchid,
    Color.forestgreen,
    Color.coral,
    Color.deeppink]
onready var players = []
onready var input_maps = []
var cursors = []

func add_player(player_index):
    var player = load("Scenes/Entities/Player.tscn").instance()
    var cursor = load("Scenes/PlacementSystem/Cursor.tscn").instance()

    players.insert(player_index, player)
    cursors.insert(player_index, cursor)
    
    player.set_color(player_cols[player_index])
    cursor.set_color(player_cols[player_index])

    add_child(cursor)
    cursor.hide()

    if player_index != 0:
        # only map controller player's input
        map_controls(player_index)
    
    if not ON_MENU:
        current_scene.add_player_to_world(players[player_index])

func player_disconnect(player_index):
    current_scene.remove_child(players[player_index])
    players[player_index].queue_free()

func map_controls(player_index):
    
    var controller_ID = player_index - 1
    print("Controller ID: " + str(controller_ID))
    
    input_maps.insert(controller_ID, {
        "right" : "ui_right{n}".format({"n":controller_ID}),
        "left" : "ui_left{n}".format({"n":controller_ID}),
        "up" : "ui_up{n}".format({"n":controller_ID}),
        "down" : "ui_down{n}".format({"n":controller_ID}),
        "select" : "select{n}".format({"n":controller_ID}),
        "rotate_cw" : "rotate_cw{n}".format({"n":controller_ID}),
        "rotate_ccw" : "rotate_ccw{n}".format({"n":controller_ID}),
        "jump" : "jump{n}".format({"n":controller_ID}),
        "sprint" : "sprint{n}".format({"n":controller_ID})
    })
    
    players[player_index].controller_ID = controller_ID
    players[player_index].movement_dict = input_maps[controller_ID]
    
    var right_action: String
    var right_action_event: InputEventJoypadMotion

    var left_action: String
    var left_action_event: InputEventJoypadMotion

    var up_action: String
    var up_action_event: InputEventJoypadMotion

    var down_action: String
    var down_action_event: InputEventJoypadMotion

    var select_action: String
    var select_action_event: InputEventJoypadButton

    var rotate_cw_action: String
    var rotate_cw_action_event: InputEventJoypadButton

    var rotate_ccw_action: String
    var rotate_ccw_action_event: InputEventJoypadButton

    var jump_action: String
    var jump_action_event: InputEventJoypadButton

    var sprint_action: String
    var sprint_action_event: InputEventJoypadButton

    right_action = "ui_right{n}".format({"n":controller_ID})
    InputMap.add_action(right_action)
    # Creat a new InputEvent instance to assign to the InputMap.
    right_action_event = InputEventJoypadMotion.new()
    right_action_event.device = controller_ID
    right_action_event.axis = JOY_AXIS_0 # <---- horizontal axis
    right_action_event.axis_value =  1.0 # <---- right
    InputMap.action_add_event(right_action, right_action_event)

    left_action = "ui_left{n}".format({"n":controller_ID})
    InputMap.add_action(left_action)
    # Creat a new InputEvent instance to assign to the InputMap.
    left_action_event = InputEventJoypadMotion.new()
    left_action_event.device = controller_ID
    left_action_event.axis = JOY_AXIS_0 # <---- horizontal axis
    left_action_event.axis_value = -1.0 # <---- left
    InputMap.action_add_event(left_action, left_action_event)

    up_action = "ui_up{n}".format({"n":controller_ID})
    InputMap.add_action(up_action)
    # Creat a new InputEvent instance to assign to the InputMap.
    up_action_event = InputEventJoypadMotion.new()
    up_action_event.device = controller_ID
    up_action_event.axis = JOY_AXIS_1 # <---- vertical axis
    up_action_event.axis_value =  -1.0 # <---- up
    InputMap.action_add_event(up_action, up_action_event)

    down_action = "ui_down{n}".format({"n":controller_ID})
    InputMap.add_action(down_action)
    # Creat a new InputEvent instance to assign to the InputMap.
    down_action_event = InputEventJoypadMotion.new()
    down_action_event.device = controller_ID
    down_action_event.axis = JOY_AXIS_1 # <---- vertical axis
    down_action_event.axis_value = 1.0 # <---- down
    InputMap.action_add_event(down_action, down_action_event)

    select_action = "select{n}".format({"n":controller_ID})
    InputMap.add_action(select_action)
    select_action_event = InputEventJoypadButton.new()
    select_action_event.device = controller_ID
    select_action_event.button_index = JOY_BUTTON_0
    select_action_event.pressed = true
    InputMap.action_add_event(select_action, select_action_event)

    rotate_cw_action = "rotate_cw{n}".format({"n":controller_ID})
    InputMap.add_action(rotate_cw_action)
    rotate_cw_action_event = InputEventJoypadButton.new()
    rotate_cw_action_event.device = controller_ID
    rotate_cw_action_event.button_index = JOY_R
    rotate_cw_action_event.pressed = true
    InputMap.action_add_event(rotate_cw_action, rotate_cw_action_event)

    rotate_ccw_action = "rotate_ccw{n}".format({"n":controller_ID})
    InputMap.add_action(rotate_ccw_action)
    rotate_ccw_action_event = InputEventJoypadButton.new()
    rotate_ccw_action_event.device = controller_ID
    rotate_ccw_action_event.button_index = JOY_L
    rotate_ccw_action_event.pressed = true
    InputMap.action_add_event(rotate_ccw_action, rotate_ccw_action_event)

    jump_action = "jump{n}".format({"n":controller_ID})
    InputMap.add_action(jump_action)
    jump_action_event = InputEventJoypadButton.new()
    jump_action_event.device = controller_ID
    jump_action_event.button_index = JOY_BUTTON_0
    jump_action_event.pressed = true
    InputMap.action_add_event(jump_action, jump_action_event)
    
    sprint_action = "sprint{n}".format({"n":controller_ID})
    InputMap.add_action(sprint_action)
    
    sprint_action_event = InputEventJoypadButton.new()
    sprint_action_event.device = controller_ID
    sprint_action_event.button_index = JOY_BUTTON_2
    sprint_action_event.pressed = true
    InputMap.action_add_event(sprint_action, sprint_action_event)

func _ready():
    var status = EventHandler.connect("scene_changed", self, "handle_scene_changed")
    assert(!status)

    var num_players = len(Input.get_connected_joypads())

    for i in range(num_players + 1):
        add_player(i)

func handle_scene_changed(previous_scene_name: String, next_scene_name: String):
    
    next_scene_name = next_scene_name.capitalize()
    
    previous_scene_name = previous_scene_name.capitalize()
    print(previous_scene_name)
    
    if not previous_scene_name == "Main Menu":
        for p in players:
            current_scene.remove_child(p)
    
    if next_scene_name == "Main Menu":
        next_scene = load("res://Scenes/UI/MainMenu/MainMenu.tscn").instance()
    
    else:
        
        ON_MENU = false
        
        match next_scene_name:
            "Hub":
                next_scene = load("res://Scenes/Maps/Hub/hub.tscn").instance()
            "Forest":
                next_scene = load("res://Scenes/Maps/map_forest.tscn").instance()
            "Valley":
                next_scene = load("res://Scenes/Maps/map_valley.tscn").instance()
            "Cliffs":
                next_scene = load("res://Scenes/Maps/map_cliffs.tscn").instance()
            "Sawmill":
                next_scene = load("res://Scenes/Maps/map_sawmill.tscn").instance()
            _:
                return
        
        for p in players:
            next_scene.add_player_to_world(p)
    
    hide_all(next_scene)
    add_child(next_scene)
    anim.play("fade_in")

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
                # Camera will always be the first child in a scene, or this will break.
                current_scene.get_child(0).current = true
                anim.play("fade_out")
