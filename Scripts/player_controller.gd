extends KinematicBody2D

onready var animator = $Position2D/AnimatedSprite
onready var position2D = $Position2D
onready var trail = $Position2D/Trail
onready var cloud = $Position2D/Cloud

# Set the character color via shader
export var charCol = Color(1.0, 1.0, 1.0, 1.0);

# Movement
const gravity : float = 512.0 # pixels/s^2
const sprint_coefficient : float = 2.0
const base_acceleration : float = 512.0 # pixels/s^2
const terminal_velocity : Vector2 = Vector2(256.0, 512.0) # pixels/s
const ground_friction : float = 0.1
const air_friction : float = 0.01
const jump_height : float = 128.0 # pixels

var velocity = Vector2.ZERO # pixels/s

# animation state machine
enum STATE {IDLE, RUN, JUMP, FALL, LAND}
var state = STATE.IDLE

# Particles
const base_initial_velocity : float = 25.0

func clampv(v : Vector2, minv : Vector2, maxv : Vector2) -> Vector2:
    return Vector2(clamp(v.x, minv.x, maxv.x), clamp(v.y, minv.y, maxv.y))

func get_input(delta : float) -> void:
    var direction = int(Input.is_action_pressed("move_right")) * Vector2.RIGHT + int(Input.is_action_pressed("move_left")) * Vector2.LEFT;

    if direction.x > 0:
        position2D.scale.x=1
    if direction.x < 0:
        position2D.scale.x=-1

    velocity += direction * pow(sprint_coefficient, int(Input.is_action_pressed("sprint"))) * base_acceleration * delta;

    trail.process_material.direction = -Vector3(direction.x, 0, 0);
    trail.process_material.initial_velocity = pow(sprint_coefficient * 0, int(Input.is_action_pressed("sprint"))) * base_initial_velocity;

    var emit = (direction != Vector2.ZERO) and is_on_floor()
    trail.emitting = emit

    if is_on_floor():
        # jump start
        if Input.is_action_just_pressed("jump"):
            state = STATE.JUMP
            velocity.y = -sqrt(2 * gravity * jump_height)
            cloud.restart()
        velocity.x = lerp(velocity.x, 0, ground_friction)
    else:
        velocity.y += gravity * delta
        velocity.x = lerp(velocity.x, 0, air_friction)
        if velocity.y > 3:
            state = STATE.FALL

    # Clamp velocity to make sure the player doesn't go too fast
    velocity = clampv(velocity, -terminal_velocity, terminal_velocity)
    # Move the player
    velocity = move_and_slide(velocity, Vector2.UP)

    if is_on_floor() and not state == STATE.LAND:
        if state == STATE.FALL:
            cloud.emitting = false
            state = STATE.LAND
        elif velocity.length() > 10:
            state = STATE.RUN
        else:
            state = STATE.IDLE

func _ready():
    material.set_shader_param("charCol", Vector3(charCol.r, charCol.g, charCol.b))

func process_anim():
    if state == STATE.IDLE:
        animator.play("idle")
    if state == STATE.RUN:
        animator.play("run")
    if state == STATE.JUMP:
        animator.play("jump")
    if state == STATE.FALL:
        animator.play("fall")
    if state == STATE.LAND:
        animator.play("land")

func _physics_process(delta : float) -> void:
    get_input(delta)
    process_anim()

func _on_AnimatedSprite_animation_finished():
    if animator.animation == "land":
        state = STATE.IDLE
