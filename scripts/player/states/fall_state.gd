extends AirState

class_name FallState

func physics_process(_delta: float) -> void :
    super.physics_process(_delta)

    player._set_velocity(Vector2(player.run_speed * input_horizontal, player.velocity.y))


    if player.is_on_floor():
        if input_horizontal == 0:
            player.change_state(IdleState.new(player, "idle"))
        else: 
            player.change_state(RunState.new(player, "run"))    