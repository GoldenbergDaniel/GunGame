extends KinematicBody2D

var gravity: float = 8

var motion: Vector2


func _process(_delta):
	if $Health.is_zero():
		queue_free()


func _physics_process(delta):
	motion.y += gravity * delta * 60
	motion = move_and_slide(motion, Vector2.UP)


func _on_Hitbox_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int):
	if area.is_in_group("Projectile"):
		take_damage(area.damage)


func take_damage(var damage: int):
	# $AnimationPlayer.play("Hurt")
	$Health.subtract(damage)
	$Sprite.modulate = Color(2, 2, 2, 1)
