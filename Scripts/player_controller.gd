extends KinematicBody2D

# Environmental consts
const gravity : float = 512.0 # pixels/s^2
const terminal_velocity : float = 256.0 # pixels/s

const base_acceleration : float = 128.0 # pixels/s^2
const base_max_speed : float = 128.0 # pixels/s
const sprint_coefficient : float = 2.0
const ground_friction : float = 0.1
const air_friction : float = 0.05
const jump_height : float = 128.0 # pixels


var velocity = Vector2.ZERO # pixels/s

func clampv(v : Vector2, minv : Vector2, maxv : Vector2) -> Vector2:
	return Vector2(clamp(v.x, minv.x, maxv.x), clamp(v.y, minv.y, maxv.y))

func get_input(delta : float) -> void:
	
	if Input.is_action_pressed("move_right"):
		velocity.x += base_max_speed;
	if Input.is_action_pressed("move_left"):
		velocity.x -= base_max_speed;
	if Input.is_action_pressed("sprint"):
		velocity.x *= sprint_coefficient
	velocity.x = clamp(velocity.x, -base_max_speed * sprint_coefficient, base_max_speed * sprint_coefficient)
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -sqrt(2 * gravity * jump_height)
		velocity.x = lerp(velocity.x, 0, ground_friction)
	else:
		velocity.y += gravity * delta
		velocity.x = lerp(velocity.x, 0, air_friction)
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _physics_process(delta : float) -> void:
	get_input(delta)
