extends GroundState

class_name IdleState

func enter() -> void:
	super.enter()

	player._set_velocity(Vector2(0, player.velocity.y))

func process(_delta: float) -> void:
	super.process(_delta)
	
	if input_horizontal != 0 && !player.is_blocked():
		player.change_state(RunState.new(player, "run"))
