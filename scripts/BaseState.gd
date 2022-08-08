class_name BaseState
extends Node

enum State {
    none,
	idle,
	move,
	jump
}

func enter(_player: KinematicBody2D) -> void:
    pass


func exit(_player: KinematicBody2D) -> void:
    pass


func physics_process(_player: KinematicBody2D, _delta: float) -> int:
    return State.none
