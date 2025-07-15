extends AirState

class_name JumpState

var jump_direction: Vector2

func _init(_player: Player, _anim_name: String, _jump_direction: Vector2) -> void:
    super._init(_player, _anim_name)

    jump_direction = _jump_direction

func enter() -> void:
    super.enter()

    player._set_velocity(jump_direction)

func physics_process(_delta: float) -> void:    
    super.physics_process(_delta)

    if player.falling():
        player.change_state(FallState.new(player, "fall"))

    if player.get_input_jump() && player.can_double_jump:
        player.can_double_jump = false
        player.change_state(JumpState.new(player, "double_jump", Vector2(player.velocity.x, -player.double_jump_force)))