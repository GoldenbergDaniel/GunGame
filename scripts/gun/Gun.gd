extends Sprite

export(Resource) var stats

export var anim_position_y: float
var original_position_y: float

var rng = RandomNumberGenerator.new()

var gun_position: Vector2
var shot_position: Vector2

var shot_timer: float
var has_shot: bool

var ammo: AmmoComponent

var BULLET: Resource = preload("res://scenes/Bullet.tscn")
var EFFECT: Resource = preload("res://scenes/effects/SmokeParticles.tscn")


func _ready():
	ammo = $Ammo
	ammo.mag_size = stats.mag_size
	ammo.reload()

	shot_timer = stats.fire_rate
	gun_position = self.position
	shot_position = $ShotPoint.position

	original_position_y = self.position.y


func _process(delta):
	if shot_timer <= stats.fire_rate:
		shot_timer += delta
	else:
		shot_timer = stats.fire_rate

	if mouse_pos_left():
		self.position.x = -gun_position.x
		$ShotPoint.position.y = -shot_position.y
	else:
		self.position.x = gun_position.x
		$ShotPoint.position.y = shot_position.y

	look_at(get_global_mouse_position())
	self.flip_v = mouse_pos_left()

	if can_shoot():
		shoot()
		Signals.emit_signal("cooldown_activated", stats.fire_rate*100)

	if Input.is_action_just_pressed("ui_reload"):
		ammo.reload()
		print("reload")


func mouse_pos_left() -> bool:
	return abs(get_global_mouse_position().x) < get_parent().position.x


func shoot() -> void:
	# Instantiate bullet
	var bullet = BULLET.instance()
	bullet.position = $ShotPoint.global_position
	bullet.rotation = $ShotPoint.global_rotation + (rng.randfn() * stats.spread) * (PI/180)
	bullet.speed = stats.speed
	bullet.damage = stats.damage
	get_node("/root/World").add_child(bullet)

	# Instantiate effect
	var effect = EFFECT.instance()
	effect.position = $ShotPoint.global_position
	get_node("/root/World").add_child(effect)

	# Play sound
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("shoot")

	# Update ammo
	ammo.subtract_one()

	# Reset timer
	shot_timer = 0


func can_shoot() -> bool:
	if shot_timer >= stats.fire_rate && !ammo.is_zero_in_mag():
		if stats.fire_type == "semi":
			return Input.is_action_just_pressed("ui_left_click")
		else:
			return Input.is_action_pressed("ui_left_click")
	return false


func animate(down: bool) -> void:
	if down:
		self.position.y = anim_position_y
	else:
		self.position.y = original_position_y
