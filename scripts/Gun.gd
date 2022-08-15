extends Sprite

export var gun_type: String = "assault_rifle"

var data: GunData
var rng = RandomNumberGenerator.new()

var shot_timer: float
var has_shot: bool

var BULLET: Resource = preload("res://scenes/Bullet.tscn")


func _ready():
	data = load("res://data/gun/" + gun_type + ".tres")
	self.frame = data.frame
	shot_timer = data.fire_rate

	self.offset = data.sprite_pivot_pos
	self.position = data.gun_point_pos
	$ShotPoint.position = data.shot_point_pos


func _process(delta):
	if shot_timer <= data.fire_rate:
		shot_timer += delta

	if shot_timer > data.fire_rate:
		shot_timer = data.fire_rate

	if mouse_pos_left():
		self.position.x = -(data.gun_point_pos.x)
		$ShotPoint.position.y = -(data.shot_point_pos.y)
	else:
		self.position.x = data.gun_point_pos.x
		$ShotPoint.position.y = data.shot_point_pos.y

	if can_fire():
		var bullet = BULLET.instance()
		bullet.position = $ShotPoint.global_position
		bullet.rotation = $ShotPoint.global_rotation + (rng.randfn() * data.spread) * (PI/180)
		bullet.speed = data.speed
		bullet.damage = data.damage
		get_node("/root/World").add_child(bullet)
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("shoot")
		shot_timer = 0

	look_at(get_global_mouse_position())
	self.flip_v = mouse_pos_left()


func mouse_pos_left() -> bool:
	return get_global_mouse_position().x < get_parent().position.x


func can_fire() -> bool:
	return Input.is_action_pressed("ui_left_click") && shot_timer >= data.fire_rate
