extends Node

func _ready():
    var root = get_node("/root")
    root.connect("size_changed",self,"resize")
    # OS.set_window_fullscreen(true)
    set_process_input(true)

#Event called when viewport size changed  
func resize():
    var root = get_node("/root")
    var resolution = root.get_visible_rect()
    print(resolution)

#Input handler, listen for ESC to exit app
func _input(event):
    if event.is_pressed() and event is InputEventKey:
        if(event.scancode == KEY_ESCAPE):
            get_tree().quit() 
