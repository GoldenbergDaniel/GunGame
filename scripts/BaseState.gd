class_name BaseState
extends Node

enum State {
	idle,
	move,
	jump
}

func enter(_player: KinematicBody2D) -> void:
    pass


func process(_player: KinematicBody2D, _delta: float) -> void:
    pass


func physics_process(_player: KinematicBody2D, _delta: float) -> void:
    pass


func exit(_player: KinematicBody2D) -> void:
    pass
