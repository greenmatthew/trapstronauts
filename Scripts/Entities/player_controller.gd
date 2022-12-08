class_name PlayerController
extends KinematicBody2D

onready var animator = $Position2D/AnimatedSprite
onready var position2D = $Position2D
onready var walking_trail = $Position2D/WalkingTrail
onready var sprinting_trail = $Position2D/SprintingTrail
onready var jumping_cloud = $Position2D/JumpingCloud
onready var landing_cloud = $Position2D/LandingCloud

#SCORE FLAGS
onready var DEAD = false
onready var GOAL = false
onready var SOLO = false
onready var FRST = false

var score_total = 0

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

var velocity : Vector2 = Vector2.ZERO # pixels/s

var is_movement_locked : bool = false

var controller_ID : int = -1

var current_vote = "Random"

var movement_dict = {
    "right": "move_right",
    "left":  "move_left",
    "up": "move_up",
    "down":  "move_down",
    "jump": "jump",
    "sprint" : "sprint",
    "select" : "place_object",
    "rotate_cw" : "rotate_clockwise",
    "rotate_ccw" : "rotate_counter_clockwise"
}

func reset():
    DEAD = false
    GOAL = false
    SOLO = false
    FRST = false
    is_movement_locked = false

# TODO: make this change the player color in MAIN
func set_color(color):
    #charCol = charCol.duplicate()
    charCol = color

func clampv(v : Vector2, minv : Vector2, maxv : Vector2) -> Vector2:
    return Vector2(clamp(v.x, minv.x, maxv.x), clamp(v.y, minv.y, maxv.y))

func new_round():
    is_movement_locked = false

func _ready():
    material.set_shader_param("charCol", Vector3(charCol.r, charCol.g, charCol.b))
    walking_trail.set_emitting(false)
    sprinting_trail.set_emitting(false)

func _physics_process(_delta : float) -> void:
    if direction() != Vector2.ZERO:
        position2D.scale.x = direction().x

func _on_AnimatedSprite_animation_finished() -> void:
    pass

func death() -> void:
    DEAD = true
    is_movement_locked = true

# func finish() -> void:
#     GOAL = true
#     is_movement_locked = true

func myjump(normal : Vector2) -> void:
    velocity += sqrt(2 * gravity * jump_height) * normal
    jumping_cloud.restart()

func apply_velocity() -> void:
    velocity = clampv(velocity, -terminal_velocity, terminal_velocity)
    velocity = move_and_slide(velocity, Vector2.UP)

func apply_velocity_grounded(delta : float) -> void:
    var acceleration_coefficient = pow(sprint_coefficient, int(is_sprinting()))
    velocity += direction() * acceleration_coefficient * base_acceleration * delta
    velocity.x = lerp(velocity.x, 0.0, ground_friction)
    velocity.y += gravity * delta
    apply_velocity()

func apply_velocity_not_grounded(delta : float) -> void:
    apply_velocity_grounded(delta)

func handle_jump_pad_jump():
    velocity.y = -3800

func get_collider_height() -> float:
    return $CollisionShape2D.shape.extents.y

# CONTROLS
func is_moving_right() -> bool:
    return not is_movement_locked and Input.is_action_pressed(movement_dict["right"])

func is_moving_left() -> bool:
    return not is_movement_locked and Input.is_action_pressed(movement_dict["left"])

func is_jumping() -> bool:
    return not is_movement_locked and Input.is_action_just_pressed(movement_dict["jump"])

func is_sprinting() -> bool:
    return not is_movement_locked and Input.is_action_pressed(movement_dict["sprint"])

func get_cursor_movement_vector() -> Vector2:
    var right = Input.get_action_strength(movement_dict["right"])
    var left = Input.get_action_strength(movement_dict["left"]) * -1
    var up = Input.get_action_strength(movement_dict["up"]) * -1
    var down = Input.get_action_strength(movement_dict["down"])

    var x = right + left
    var y = up + down
    return Vector2(x, y)

func is_cursor_sprinting() -> bool:
    return Input.is_action_pressed(movement_dict["sprint"])

func select_input() -> bool:
    return Input.is_action_just_released(movement_dict["select"])

func rotate_cw() -> bool:
    return Input.is_action_just_released(movement_dict["rotate_cw"])

func rotate_ccw() -> bool:
    return Input.is_action_just_released(movement_dict["rotate_ccw"])

func direction() -> Vector2:
    var dir = Vector2.ZERO
    if is_moving_right():
        dir += Vector2.RIGHT
    if is_moving_left():
        dir += Vector2.LEFT
    return dir
