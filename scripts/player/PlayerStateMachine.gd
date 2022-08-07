class_name PlayerStateMachine
extends Node

enum State {
	idle,
	run,
	jump,
	attack
}

var current_state = State.idle


func get_state() -> int:
	return current_state


func change_state(new_state: int):
	current_state = new_state
