class_name PlayerIdleState
extends BaseState


func enter(player: KinematicBody2D) -> void:
	.enter(player)

	player.animation_player.playback_speed = 0.2
	player.animation_player.play("idle_armed")


func physics_process(player: KinematicBody2D, delta: float) -> void:
	player.velocity.y += player.gravity * delta * 60
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if player.is_on_floor():
		player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.air_resistance * delta)

	if Input.is_action_pressed("ui_up"):
		player.change_state(State.jump)

	if Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		player.change_state(State.move)
