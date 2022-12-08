extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 10.0
const title_color := Color.green

var speed_up := false

onready var line := $Container/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []


var credits_filepath : String = "res://credits.txt"
var credits = []

func _ready():
    # read credits from file
    credits = _read_credits_from_file()

func _process(delta):
    var scroll_speed = base_speed * delta
    
    if section_next:
        section_timer += delta * speed_up_multiplier if speed_up else delta
        if section_timer >= section_time:
            section_timer -= section_time
            
            if credits.size() > 0:
                started = true
                section = credits.pop_front()
                curr_line = 0
                add_line()
    
    else:
        line_timer += delta * speed_up_multiplier if speed_up else delta
        if line_timer >= line_time:
            line_timer -= line_time
            add_line()
    
    if speed_up:
        scroll_speed *= speed_up_multiplier
    
    if lines.size() > 0:
        for l in lines:
            l.rect_position.y -= scroll_speed
            if l.rect_position.y < -l.get_line_height():
                lines.erase(l)
                l.queue_free()
    elif started:
        finish()

func _read_credits_from_file():
    credits = []
    var current_section : Array = []
    var file = File.new()
    if file.open(credits_filepath, File.READ) == OK:
        while not file.eof_reached():
            var current_line = file.get_line()
            if current_line != "":
                if current_line[0] == '[' and current_line[-1] == ']':
                    if not current_section.empty():
                        credits.append(current_section)
                        current_section = []
                    current_section.append(current_line.substr(1, current_line.length() - 2))
                else:
                    current_section.append(current_line)
        # Flush out the last section and content if there is any
        if not current_section.empty():
            credits.append(current_section)

        file.close()
        return credits

func finish():
    if not finished:
        finished = true
        get_tree().change_scene("res://Scenes/Main.tscn")

func add_line():
    var new_line = line.duplicate()
    new_line.text = section.pop_front()
    lines.append(new_line)
    if curr_line == 0:
        new_line.add_color_override("font_color", title_color)
    $Container.add_child(new_line)
    
    if section.size() > 0:
        curr_line += 1
        section_next = false
    else:
        section_next = true


func _unhandled_input(event):
    if event.is_action_pressed("ui_cancel"):
        finish()
    if event.is_action_pressed("ui_select") and !event.is_echo():
        get_tree().change_scene("res://Scenes/Main.tscn")
      
