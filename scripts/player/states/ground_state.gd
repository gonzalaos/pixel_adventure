extends PlayerState

class_name GroundState

func enter() -> void:
    super.enter()
    player.can_double_jump = true

func process(_delta: float) -> void:
    super.process(_delta)

    player.flip(input_horizontal)

    if player.get_input_jump():
        player.change_state(JumpState.new(player, "jump", player.jump_force))

func physics_process(_delta: float) -> void:
    super.physics_process(_delta)

    if !player.is_on_floor() && player.falling():
        player.change_state(FallState.new(player, "fall"))
