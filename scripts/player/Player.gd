class_name Player
extends KinematicBody2D

var gravity: float = 8
var movement_speed: float = 60
var jump_force: float = 160
var acceleration: float = 60
var friction: float = 24
var air_resistance: float = 8

var input: Vector2
var velocity: Vector2

onready var pivot: Position2D = $Pivot
onready var sprite: Sprite = $Pivot/Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_state: int

onready var state_map = {
	BaseState.State.idle: $State/Idle,
	BaseState.State.move: $State/Move,
	BaseState.State.jump: $State/Move/Jump
}

var PISTOL: Resource = preload("res://scenes/gun/Pistol.tscn")
var SMG: Resource = preload("res://scenes/gun/SMG.tscn")


func _ready() -> void:
	change_state(BaseState.State.idle)
	sprite.frame = 0

	Signals.emit_signal("health_updated", get_current_health())

	equip_gun(0)


func _process(delta: float) -> void:
	state_map[current_state].process(self, delta)

	if get_global_mouse_position().x < self.position.x:
		pivot.scale.x = -1
	else:
		pivot.scale.x = 1

	# Gun switching
	if Input.is_action_just_pressed("ui_gun_slot_1"):
		equip_gun(0)
	if Input.is_action_just_pressed("ui_gun_slot_2"):
		equip_gun(1)


func _physics_process(delta: float) -> void:
	state_map[current_state].physics_process(self, delta)


func change_state(new_state: int) -> void:
	state_map[current_state].exit(self)
	current_state = new_state
	state_map[current_state].enter(self)


func is_gun_equipped() -> bool:
	return pivot.has_node("Gun")


func equip_gun(gun_id: int) -> void:
	if is_gun_equipped():
		pivot.get_node("Gun").free()

	var gun
	if gun_id == 1:
		gun = SMG.instance()
	else:
		gun = PISTOL.instance()
	
	gun.name = "Gun"
	pivot.add_child(gun)


func animate_gun(down: bool) -> void:
	if is_gun_equipped():
		pivot.get_node("Gun").animate(down)


func get_current_health() -> int:
	return $Health.current_health

