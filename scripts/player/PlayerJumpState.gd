class_name PlayerJumpState
extends PlayerMoveState


func enter(player: KinematicBody2D) -> void:
	.enter(player)

	player.velocity.y = -player.jump_force
	player.animation_player.play("jump_up_armed")


func physics_process(player: KinematicBody2D, delta: float) -> void:
	.physics_process(player, delta)

	if player.is_on_floor():
		if player.input.x == 0:
			player.change_state(State.idle)
		else:
			player.change_state(State.move)


func exit(player: KinematicBody2D) -> void:
	.exit(player)

	player.animation_player.play("jump_down_armed")
