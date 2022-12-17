class_name BaseState
extends Node

enum State {
	idle,
	move,
	jump
}

func enter(_base: KinematicBody2D) -> void:
    pass


func process(_base: KinematicBody2D, _delta: float) -> void:
    pass


func physics_process(_base: KinematicBody2D, _delta: float) -> void:
    pass


func exit(_base: KinematicBody2D) -> void:
    pass
