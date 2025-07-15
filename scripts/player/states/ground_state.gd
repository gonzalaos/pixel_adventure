extends PlayerState

class_name GroundState

func enter() -> void:
    super.enter()

    player.can_double_jump = true
    player.coyote_timer = player.coyote_time

func process(_delta: float) -> void:
    super.process(_delta)

    player.flip(input_horizontal)

    if player.get_input_jump():
        player.change_state(JumpState.new(player, "jump", Vector2(player.velocity.x, -player.jump_force)))

func physics_process(_delta: float) -> void:
    super.physics_process(_delta)

    player.apply_gravity(_delta, player.GRAVITY)

    if !player.is_on_floor() && player.falling():
        player.change_state(FallState.new(player, "fall"))