class_name PlayerIdleState
extends BaseState


func physics_process(player: KinematicBody2D, delta: float) -> int:
	player.velocity.y += player.gravity * delta * 60
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if player.is_on_floor():
		player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.air_resistance * delta)

	if Input.is_action_pressed("ui_up"):
		return State.jump

	if Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		return State.move

	return State.none