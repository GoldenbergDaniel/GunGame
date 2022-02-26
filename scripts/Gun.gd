extends Sprite

var data: GunData
var rng = RandomNumberGenerator.new()

export var type: String

var BULLET: Resource = preload("res://scenes/Bullet.tscn")


func _ready():
	data = load("res://data/gun/" + type + ".tres")
	frame = data.frame

	position = data.pivot_point_pos
	$ShotPoint.position = data.shot_point_pos


func _process(_delta):
	if mouse_pos_left():
		position.x = -(data.pivot_point_pos.x)
		$ShotPoint.position.y = -(data.shot_point_pos.y)
	else:
		position.x = data.pivot_point_pos.x
		$ShotPoint.position.y = data.shot_point_pos.y

	if Input.is_action_just_pressed("ui_left_click"):
		var bullet = BULLET.instance()
		get_parent().get_parent().add_child(bullet)
		bullet.position = $ShotPoint.global_position
		bullet.rotation = $ShotPoint.global_rotation + (rng.randf_range(-1, 1) * data.spread) * (PI/180)
		# $Fire.visible = true
	# else: 
	# 	$Fire.visible = false

	look_at(get_global_mouse_position())
	flip_v = mouse_pos_left()


func mouse_pos_left() -> bool:
	return get_global_mouse_position().x < get_parent().position.x
