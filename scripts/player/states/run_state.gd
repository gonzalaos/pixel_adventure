extends GroundState

class_name RunState

func process(_delta: float) -> void:
    super.process(_delta)

    if input_horizontal == 0 || player.is_blocked():
        player.change_state(IdleState.new(player, "idle"))

func physics_process(_delta: float) -> void:
    super.physics_process(_delta)
    
    player._set_velocity(Vector2(player.run_speed * input_horizontal, player.velocity.y))