class_name PlayerJumpState
extends PlayerMoveState


func enter(player: KinematicBody2D) -> void:
	.enter(player)

	player.velocity.y = -player.jump_force


func physics_process(player: KinematicBody2D, delta: float) -> int:
	var new_state: int = .physics_process(player, delta)
	if new_state != State.none:
		return new_state

	if player.is_on_floor():
		if player.input.x == 0:
			return State.idle
		else:
			return State.move

	return State.none
