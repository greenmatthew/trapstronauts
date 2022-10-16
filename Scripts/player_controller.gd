extends KinematicBody2D

onready var animator = $Position2D/AnimatedSprite
onready var position2D = $Position2D
onready var walking_trail = $Position2D/WalkingTrail
onready var sprinting_trail = $Position2D/SprintingTrail
onready var jumping_cloud = $Position2D/JumpingCloud
onready var landing_cloud = $Position2D/LandingCloud

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
const wall_slide_velocity : float = 64.0 # pixels/s

var forward : Vector2 = Vector2.RIGHT # Direction the character is facing
var direction : Vector2 = Vector2.ZERO # Direction the character is moving
var velocity : Vector2 = Vector2.ZERO # pixels/s
var acceleration_coefficient : float = 1.0

# Movement Flags
var is_grounded : bool = false
var is_touching_wall : bool = false
var is_sprint_button_down : bool = false
var is_jump_button_down = false
var is_jumping : bool = false
var is_falling : bool = false
var is_wall_sliding : bool = false
var has_input : bool = false

# animation state machine
enum STATE {IDLE, RUN, JUMP, FALL, LAND}
var state = STATE.IDLE

# Particles
const base_initial_velocity : float = 25.0

func clampv(v : Vector2, minv : Vector2, maxv : Vector2) -> Vector2:
    return Vector2(clamp(v.x, minv.x, maxv.x), clamp(v.y, minv.y, maxv.y))

func get_input(delta : float) -> void:
    is_grounded = is_on_floor()
    is_touching_wall = is_on_wall()
    is_sprint_button_down = Input.is_action_pressed("sprint")
    is_jump_button_down = Input.is_action_just_pressed("jump")
    is_jumping = not is_grounded and velocity.y < 0.0
    is_wall_sliding = is_touching_wall and not is_grounded and velocity.y > 0.0
    is_falling = not is_grounded and not is_wall_sliding and velocity.y > 0.0
    #has_landed = 
    has_input = direction.length() > 0

    acceleration_coefficient = pow(sprint_coefficient, int(Input.is_action_pressed("sprint")))
    direction = int(Input.is_action_pressed("move_right")) * Vector2.RIGHT + int(Input.is_action_pressed("move_left")) * Vector2.LEFT;

    set_graphics_direction()

    velocity += direction * acceleration_coefficient * base_acceleration * delta;
    
    # trail.process_material.initial_velocity = pow(sprint_coefficient * 0, int(Input.is_action_pressed("sprint"))) * base_initial_velocity;
    if has_input and is_grounded:
        if is_sprint_button_down:
            sprinting_trail.emitting = true
            walking_trail.emitting = false
        else:
            sprinting_trail.emitting = false
            walking_trail.emitting = true
    else:
        sprinting_trail.emitting = false
        walking_trail.emitting = false

    if is_grounded or is_touching_wall:
        if is_jump_button_down:
            jump()
        else:
            if not is_jumping or not is_falling:
                velocity.y = 0.0
            # if is_grounded:
            #     velocity.y = 0.0
            # elif direction.normalized().dot(forward) < 0.0:
            #     velocity.y = wall_slide_velocity
        velocity.x = lerp(velocity.x, 0.0, ground_friction)
    else:
        velocity.x = lerp(velocity.x, 0.0, air_friction)
        velocity.y += gravity * delta    

    # if is_grounded:
    #     # jump start
    #     if is_jump_button_down:
    #         jump()
    #     else:
    #         velocity.y = 0.0
    #     velocity.x = lerp(velocity.x, 0.0, ground_friction)
    # else:
    #     velocity.x = lerp(velocity.x, 0.0, air_friction)
    #     velocity.y += gravity * delta
        # if velocity.y > 3.0:
        #     state = STATE.FALL

    set_state()

    # if is_on_floor() and not state == STATE.LAND:
    #     if state == STATE.FALL:
    #         cloud.emitting = false
    #         state = STATE.LAND
    #     elif velocity.length() > 10:
    #         state = STATE.RUN
    #     else:
    #         state = STATE.IDLE

    # Clamp velocity to make sure the player doesn't go too fast
    velocity = clampv(velocity, -terminal_velocity, terminal_velocity)
    # Move the player
    velocity = move_and_slide(velocity, Vector2.UP)

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
        landing_cloud.restart()

func set_graphics_direction() -> void:
    if direction.x > 0:
        position2D.scale.x=1
        forward = Vector2.RIGHT
    if direction.x < 0:
        position2D.scale.x=-1
        forward = Vector2.LEFT

    walking_trail.process_material.direction = -Vector3(direction.x, 0, 0);
    sprinting_trail.process_material.direction = -Vector3(direction.x, 0, 0);

func jump():
    state = STATE.JUMP
    velocity.y = -sqrt(2 * gravity * jump_height)
    jumping_cloud.restart()

func set_state():
    if is_jumping:
        state = STATE.JUMP
    elif is_falling:
        # cloud.emitting = false
        state = STATE.FALL
    elif has_input:
        state = STATE.RUN
    else:
        state = STATE.IDLE
    
