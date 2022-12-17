class_name EnemyIdleState
extends BaseState


func enter(base: KinematicBody2D) -> void:
	.enter(base)

	base.animation_player.playback_speed = 0.2
	base.animation_player.play("idle_armed")


func physics_process(base: KinematicBody2D, delta: float) -> void:
	base.velocity.y += base.gravity * delta * 60
	base.velocity = base.move_and_slide(base.velocity, Vector2.UP)

	if base.is_on_floor():
		base.velocity.x = lerp(base.velocity.x, 0, base.friction * delta)
	else:
		base.velocity.x = lerp(base.velocity.x, 0, base.air_resistance * delta)

	# if jump:
	# 	base.change_state(State.jump)

	# if move:
	# 	base.change_state(State.move)
