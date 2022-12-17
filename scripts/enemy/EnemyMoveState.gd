class_name EnemyMoveState
extends BaseState


func enter(base: KinematicBody2D):
	base.animation_player.playback_speed = 1.5


func process(base: KinematicBody2D, _delta: float) -> void:
	if base.current_state != State.jump:
		base.animation_player.play("move_armed")
		if base.input.x == 0:
			base.animation_player.stop()


func physics_process(base: KinematicBody2D, delta: float) -> void:
	base.input = Vector2.ZERO
	base.input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if base.input.x != 0:
		base.velocity.x += base.input.x * base.acceleration * delta * 60
		base.velocity.x = clamp(base.velocity.x, -base.movement_speed, base.movement_speed)
	else:
		if base.is_on_floor():
			base.velocity.x = lerp(base.velocity.x, 0, base.friction * delta)
		else:
			base.velocity.x = lerp(base.velocity.x, 0, base.air_resistance * delta)

	base.velocity.y += base.gravity * delta * 60
	base.velocity = base.move_and_slide(base.velocity, Vector2.UP)

	# if base.current_state != State.jump:
	# 	if stopped:
	# 		base.change_state(State.idle)
	# 	if jumping:
	# 		base.change_state(State.jump)


func exit(base: KinematicBody2D):
	base.animation_player.stop(true)
	base.animation_player.playback_speed = 1
	base.sprite.frame = 0
