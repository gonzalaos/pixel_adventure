extends PlayerState

class_name AirState

func process(_delta: float) -> void:
    super.process(_delta)

    player.flip(input_horizontal)

    player.coyote_timer -= _delta  

func physics_process(_delta: float) -> void:    
    super.physics_process(_delta)

    player.apply_gravity(_delta, player.GRAVITY)