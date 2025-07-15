extends CharacterBody2D

class_name Player

const GRAVITY: float = 1000

#region Variables and checks
@export var run_speed: float
@export var jump_force: float
@export var double_jump_force: float

var coyote_time: float = 0.2
var coyote_timer: float = 0
var jump_buffer_time: float = 0.1
var jump_buffer_timer: float = 0
var wall_jump_buffer_time: float = 0.1
var wall_jump_buffer_timer: float = 0
var horizontal_input_buffer_time: float = 0.1
var horizontal_input_buffer_timer: float = 0

var can_double_jump
#endregion

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_check: RayCast2D = $WallCheck

var current_state: PlayerState

func _ready() -> void:
	change_state(IdleState.new(self, "idle"))

func _process(delta: float) -> void:
	if current_state: current_state.process(delta)

func _physics_process(delta: float) -> void:
	if current_state: current_state.physics_process(delta)
	move_and_slide()

func change_state(new_state: PlayerState) -> void:
	if current_state: current_state.exit()
	current_state = new_state
	current_state.enter()

func play_animation(anim_name: String) -> void:
	anim_sprite.play(anim_name)

#region Inputs
func get_input_horizontal() -> float:
	return Input.get_axis("move_left", "move_right")   

func get_input_jump() -> bool:
	return Input.is_action_just_pressed("jump")    
#endregion

func apply_gravity(_delta: float, _velocity: float) -> void:
	velocity.y += _velocity * _delta

func _set_velocity(new_velocity: Vector2) -> void:
	velocity = new_velocity

func flip(input_horizontal: float) -> void:
	if input_horizontal != 0:
		anim_sprite.flip_h = false if input_horizontal > 0 else true
		wall_check.target_position.x = 10.5 if input_horizontal > 0 else -10.5

func is_blocked() -> bool:
	return wall_check.is_colliding()

func get_wall_collision_point() -> Vector2:
	return wall_check.get_collision_point()

func falling() -> bool:
	return velocity.y >= 0	