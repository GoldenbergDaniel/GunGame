extends Node

export var total_health: int
var current_health: int

func _ready():
	current_health = total_health


func add(health: int):
	current_health += health
	if current_health > total_health:
		current_health = total_health


func subtract(health: int):
	current_health -= health
	if current_health < 0:
		current_health = 0

func is_zero() -> bool:
	return current_health == 0
