extends AirState

class_name JumpState

var jump_force: float

func _init(_player: Player, _anim_name: String, _jump_force: float) -> void:
    super._init(_player, _anim_name)
    jump_force = _jump_force

func enter() -> void:
    super.enter()

    player._set_velocity(Vector2(player.velocity.x, -jump_force))

func physics_process(_delta: float) -> void:    
    super.physics_process(_delta)

    if player.falling():
        player.change_state(FallState.new(player, "fall"))