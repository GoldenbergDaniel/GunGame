extends Area2D

export var speed: float = 100


func _physics_process(delta):
	position += Vector2(1, 0).rotated(rotation) * speed * delta 
