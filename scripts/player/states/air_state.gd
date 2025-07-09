extends PlayerState

class_name AirState

func process(_delta: float) -> void:
    super.process(_delta)

    player.flip(input_horizontal)

    if player.get_input_jump() && player.can_double_jump:
        player.can_double_jump = false
        player.change_state(JumpState.new(player, "double_jump", player.double_jump_force))


func physics_process(_delta: float) -> void:    
    super.physics_process(_delta)

    player.apply_gravity(_delta)