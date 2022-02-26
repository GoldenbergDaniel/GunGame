extends KinematicBody2D

export var gravity: float = 8
export var movement_speed: float = 60
export var jump_force: float = 120
export var acceleration: float = 60
export var friction: float = 24
export var air_resistance: float = 12
export var max_jump_count: int = 1

var motion: Vector2
var input: Vector2

var jump_count: int
var grounded_remember_time: float
var jump_remember_time: float
var was_on_ground: bool

var spawn_point: Node2D
export var spawn_point_ref: NodePath


func _ready():
	spawn_point = get_node(spawn_point_ref)


func _process(_delta):
	$Sprite.flip_h = mouse_pos_left()


func _physics_process(delta):
	input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if input.x != 0:
		motion.x += input.x * acceleration * delta * 60
		motion.x = clamp(motion.x, -movement_speed, movement_speed)
	else:
		if is_on_floor():
			motion.x = lerp(motion.x, 0, friction * delta)
		else:
			motion.x = lerp(motion.x, 0, air_resistance * delta)
	
	if max_jump_count > 1:
		if is_on_floor():
			jump_count = max_jump_count
			if Input.is_action_just_pressed("ui_up"):
				was_on_ground = true
		if Input.is_action_just_pressed("ui_up"):
			if was_on_ground && jump_count > 0 || !was_on_ground && jump_count > 1:
				jump_count -= 1
				motion.y = -jump_force
		if jump_count == 0:
			was_on_ground = false
	else:
		grounded_remember_time -= delta
		jump_remember_time -= delta
		if is_on_floor():
			grounded_remember_time = 0.15
		if Input.is_action_pressed("ui_up") && grounded_remember_time > 0 && jump_remember_time < 0:
			jump_remember_time = 0.3
			grounded_remember_time = 0
			motion.y = -jump_force

	motion.y += gravity * delta * 60
	motion = move_and_slide(motion, Vector2.UP)


func _on_ResetField_body_shape_entered(_body_id: int, _body: KinematicBody2D, _body_shape: CollisionShape2D, _local_shape: CollisionShape2D):
	position = spawn_point.position
	motion = Vector2.ZERO


func mouse_pos_left() -> bool:
	return get_global_mouse_position().x < position.x
