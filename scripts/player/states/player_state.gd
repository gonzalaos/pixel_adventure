extends Node

class_name PlayerState

var player: Player
var anim_name: String

func _init(_player: Player, _anim_name: String) -> void:
    player = _player
    anim_name = _anim_name

func enter() -> void:
    player.play_animation(anim_name)

func process(_delta: float) -> void:
    pass

func physics_process(_delta: float) -> void:
    pass

func exit() -> void:
    pass