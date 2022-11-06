class_name PlayerController
extends KinematicBody2D

onready var animator = $Position2D/AnimatedSprite
onready var position2D = $Position2D
onready var walking_trail = $Position2D/WalkingTrail
onready var sprinting_trail = $Position2D/SprintingTrail
onready var jumping_cloud = $Position2D/JumpingCloud
onready var landing_cloud = $Position2D/LandingCloud

var ui_inputs = {
	"right": "move_right",
	"left":  "move_left",
	"jump": "jump",
	"sprint" : "sprint"
	}

# Set the character color via shader
var charCol = Color.white

# Movement
const gravity : float = 2048.0 # pixels/s^2
const sprint_coefficient : float = 2.0
const base_acceleration : float = 2048.0 # pixels/s^2
const terminal_velocity : Vector2 = Vector2(1024.0, 2058.0) # pixels/s
const ground_friction : float = 0.1
const air_friction : float = 0.01
const jump_height : float = 512.0 # pixels
const wall_slide_terminal_velocity : float = 256.0 # pixels/s

var forward : Vector2 = Vector2.RIGHT # Direction the character is facing
# var direction : Vector2 = Vector2.ZERO # Direction the character is moving
var direction : Vector2 = Vector2.ZERO setget , get_direction
var velocity : Vector2 = Vector2.ZERO # pixels/s

# Movement Flags
var is_grounded : bool = false
var is_touching_wall : bool = false
var is_sprint_button_down : bool = false
var is_jump_button_down = false
var is_jumping : bool = false
var is_falling : bool = false
var is_wall_sliding : bool = false
var has_input : bool = false

#TODO make this change the player color in MAIN
func set_color(color):
	#charCol = charCol.duplicate()
	charCol = color

func clampv(v : Vector2, minv : Vector2, maxv : Vector2) -> Vector2:
	return Vector2(clamp(v.x, minv.x, maxv.x), clamp(v.y, minv.y, maxv.y))

func _ready():
	material.set_shader_param("charCol", Vector3(charCol.r, charCol.g, charCol.b))
	walking_trail.set_emitting(false)
	sprinting_trail.set_emitting(false)

func _physics_process(_delta : float) -> void:
	var dir = get_direction()
	if dir.x > 0:
		position2D.scale.x = 1
		forward = Vector2.RIGHT
	if dir.x < 0:
		position2D.scale.x = -1
		forward = Vector2.LEFT

func _on_AnimatedSprite_animation_finished() -> void:
	pass

func death() -> void:
	var _touched_player = get_tree().reload_current_scene()

func myjump(normal : Vector2) -> void:
	velocity += sqrt(2 * gravity * jump_height) * normal
	jumping_cloud.restart()
	
func get_direction() -> Vector2:
	if Input.is_action_pressed(ui_inputs.get("right")):
		return Vector2.RIGHT
	if Input.is_action_pressed(ui_inputs.get("left")):
		return Vector2.LEFT
	return Vector2.ZERO

func apply_velocity() -> void:
	velocity = clampv(velocity, -terminal_velocity, terminal_velocity)
	velocity = move_and_slide(velocity, Vector2.UP)

func apply_velocity_grounded(delta : float) -> void:
	var acceleration_coefficient = pow(sprint_coefficient, int(Input.is_action_pressed(ui_inputs.get("sprint"))))
	velocity += get_direction() * acceleration_coefficient * base_acceleration * delta
	velocity.x = lerp(velocity.x, 0.0, ground_friction)
	velocity.y += gravity * delta
	apply_velocity()

func apply_velocity_not_grounded(delta : float) -> void:
	apply_velocity_grounded(delta)


func _on_JumpPad_body_entered(_body):
	velocity.y = -3800
