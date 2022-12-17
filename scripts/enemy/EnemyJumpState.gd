class_name EnemyJumpState
extends EnemyMoveState


func enter(base: KinematicBody2D) -> void:
	.enter(base)

	base.velocity.y = -base.jump_force
	base.animation_player.play("jump_up_armed")


func physics_process(base: KinematicBody2D, delta: float) -> void:
	.physics_process(base, delta)

	if base.is_on_floor():
		if base.input.x == 0:
			base.change_state(State.idle)
		else:
			base.change_state(State.move)


func exit(base: KinematicBody2D) -> void:
	.exit(base)

	base.animation_player.play("jump_down_armed")
