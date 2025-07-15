extends PlayerState

class_name WallSlide

var horizontal_dir: int = 0

func enter() -> void:
	super.enter()

	player._set_velocity(Vector2(0.0, 25.0))

func process(_delta) -> void:
	super.process(_delta)

	if player.get_input_jump():
		player.wall_jump_buffer_timer = player.wall_jump_buffer_time

	if player.wall_jump_buffer_timer > 0:
		player.wall_jump_buffer_timer -= _delta 

	if input_horizontal != 0:
		horizontal_dir = sign(input_horizontal)
		player.horizontal_input_buffer_timer = player.horizontal_input_buffer_time

	if player.horizontal_input_buffer_timer > 0:
		player.horizontal_input_buffer_timer -= _delta

func physics_process(_delta: float) -> void:    
	super.physics_process(_delta)

	if player.is_on_floor():
		player.change_state(IdleState.new(player, "idle"))
	
	if !player.is_on_floor() && !player.is_blocked():
		player.change_state(FallState.new(player, "fall"))

	if player.horizontal_input_buffer_timer > 0 \
		&& player.wall_jump_buffer_timer == 0 \
		&& horizontal_dir == sign(player.wall_check.get_collision_normal().x) && !player.is_on_floor():
			player.horizontal_input_buffer_timer = 0
			player.change_state(FallState.new(player, "fall"))

	var jump_x: float
	var direction: int = 1 if player.anim_sprite.flip_h else -1

	if player.wall_jump_buffer_timer > 0 && player.horizontal_input_buffer_timer > 0:
		player.wall_jump_buffer_timer = 0
		player.horizontal_input_buffer_timer = 0

		if horizontal_dir == player.wall_check.get_collision_normal().x:
			player.flip(input_horizontal)
			jump_x = horizontal_dir * 100
		elif (horizontal_dir != player.wall_check.get_collision_normal().x):
			player.anim_sprite.flip_h = !player.anim_sprite.flip_h
			jump_x = direction * 30.0
		player.change_state(JumpState.new(player, "jump", Vector2(jump_x, -250)))

	if player.wall_jump_buffer_timer < 0:
		player.wall_jump_buffer_timer = 0
		player.anim_sprite.flip_h = !player.anim_sprite.flip_h
		jump_x = direction * 30.0
		player.change_state(JumpState.new(player, "jump", Vector2(jump_x, -250)))