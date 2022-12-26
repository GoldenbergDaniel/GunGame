extends Node
class_name HealthComponent

export var total_health: int
var current_health: int


func _ready() -> void:
	current_health = total_health


func add(health: int) -> void:
	current_health += health
	if current_health > total_health:
		current_health = total_health


func subtract(health: int) -> void:
	current_health -= health
	if current_health < 0:
		current_health = 0


func is_zero() -> bool:
	return current_health == 0
