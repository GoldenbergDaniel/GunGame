class_name PlayerMoveState
extends BaseState


func physics_process(player: KinematicBody2D, delta: float) -> int:
	player.input = Vector2.ZERO
	player.input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if player.input.x != 0:
		player.velocity.x += player.input.x * player.acceleration * delta * 60
		player.velocity.x = clamp(player.velocity.x, -player.movement_speed, player.movement_speed)
	else:
		if player.is_on_floor():
			player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
		else:
			player.velocity.x = lerp(player.velocity.x, 0, player.air_resistance * delta)

	player.velocity.y += player.gravity * delta * 60
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if player.current_state != State.jump:
		if !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
			return State.idle
		if Input.is_action_pressed("ui_up"):
			return State.jump

	return State.none
