extends PlayerState

class_name GroundState

var input_horizontal: float

func enter() -> void:
    super.enter()

func process(_delta: float) -> void:
    super.process(_delta)
    input_horizontal = player.get_input_horizontal()
    player.flip(input_horizontal)

func physics_process(_delta: float) -> void:
    super.physics_process(_delta)
