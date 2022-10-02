extends KinematicBody2D

# Movement
const gravity : float = 512.0 # pixels/s^2
const sprint_coefficient : float = 2.0
const base_acceleration : float = 512.0 # pixels/s^2
const terminal_velocity : Vector2 = Vector2(256.0, 512.0) # pixels/s
const ground_friction : float = 0.1
const air_friction : float = 0.01
const jump_height : float = 128.0 # pixels

var velocity = Vector2.ZERO # pixels/s

# Particles
const base_initial_velocity : float = 25.0

func clampv(v : Vector2, minv : Vector2, maxv : Vector2) -> Vector2:
    return Vector2(clamp(v.x, minv.x, maxv.x), clamp(v.y, minv.y, maxv.y))

func get_input(delta : float) -> void:
    var direction = int(Input.is_action_pressed("move_right")) * Vector2.RIGHT + int(Input.is_action_pressed("move_left")) * Vector2.LEFT;
    velocity += direction * pow(sprint_coefficient, int(Input.is_action_pressed("sprint"))) * base_acceleration * delta;

    $Trail.process_material.direction = -Vector3(direction.x, 0, 0);
    $Trail.process_material.initial_velocity = pow(sprint_coefficient * 0, int(Input.is_action_pressed("sprint"))) * base_initial_velocity;
    $Trail.emitting = direction != Vector2.ZERO and is_on_floor();


    if is_on_floor():
        if Input.is_action_just_pressed("jump"):
            velocity.y = -sqrt(2 * gravity * jump_height)
            $Cloud.emitting = true
        velocity.x = lerp(velocity.x, 0, ground_friction)
    else:
        velocity.y += gravity * delta
        velocity.x = lerp(velocity.x, 0, air_friction)

    

    # Clamp velocity to make sure the player doesn't go too fast
    velocity = clampv(velocity, -terminal_velocity, terminal_velocity)
    # Move the player
    velocity = move_and_slide(velocity, Vector2.UP)

func _ready():
    $Trail.emitting = false
    $Cloud.emitting = false

func _physics_process(delta : float) -> void:
    get_input(delta)
