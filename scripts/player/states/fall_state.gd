extends AirState

class_name FallState

func process(_delta):
    super.process(_delta)

    if player.get_input_jump():
        player.jump_buffer_timer = player.jump_buffer_time

    if player.jump_buffer_timer > 0:
        player.jump_buffer_timer -= _delta  

func physics_process(_delta: float) -> void :
    super.physics_process(_delta)

    player._set_velocity(Vector2(player.run_speed * input_horizontal, player.velocity.y))

    if player.is_on_floor():
        if input_horizontal == 0:
            player.change_state(IdleState.new(player, "idle"))
        else: 
            player.change_state(RunState.new(player, "run"))      

    if player.jump_buffer_timer > 0 && (player.is_on_floor() || player.coyote_timer > 0):
        player.jump_buffer_timer = 0.0
        player.change_state(JumpState.new(player, "jump", Vector2(player.velocity.x, -player.jump_force)))

    if player.jump_buffer_timer > 0 && !player.is_on_floor() && player.coyote_timer < 0 && player.can_double_jump:
        player.jump_buffer_timer = 0.0
        player.can_double_jump = false
        player.change_state(JumpState.new(player, "double_jump", Vector2(player.velocity.x, -player.double_jump_force)))

    if player.is_blocked():
        player.global_position = player.get_wall_collision_point()
        player.change_state(WallSlide.new(player, "wall_slide"))        