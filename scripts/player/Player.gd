class_name Player
extends KinematicBody2D

export var gun_type: String

var gravity: float = 8
var movement_speed: float = 60
var jump_force: float = 160
var acceleration: float = 60
var friction: float = 24
var air_resistance: float = 8

var input: Vector2
var velocity: Vector2

onready var state_map = {
	BaseState.State.idle: $State/Idle,
	BaseState.State.move: $State/Move,
	BaseState.State.jump: $State/Move/Jump
}

var current_state: int


func _ready():
	current_state = BaseState.State.idle


func _process(_delta: float) -> void:
	if mouse_pos_left():
		get_node("Pivot").scale.x = -1
	else:
		get_node("Pivot").scale.x = 1


func _physics_process(delta: float) -> void:
	var new_state = state_map[current_state].physics_process(self, delta)
	if new_state != BaseState.State.none:
		change_state(new_state)


func change_state(new_state: int) -> void:
	state_map[current_state].exit(self)
	current_state = new_state
	state_map[current_state].enter(self)


func mouse_pos_left() -> bool:
	return get_global_mouse_position().x < self.position.x
