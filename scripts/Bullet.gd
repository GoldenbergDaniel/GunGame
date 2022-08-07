extends Area2D

var speed: int
var damage: int

var EFFECT: Resource = preload("res://scenes/effects/BulletParticles.tscn")


func _process(_delta):
	if $Timer.is_stopped():
		queue_free()


func _physics_process(delta):
	self.position += Vector2(1, 0).rotated(self.rotation) * speed * delta 


func _on_Bullet_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int):
	var effect = EFFECT.instance()
	effect.position = self.position
	get_node("/root/World").add_child(effect)
	queue_free()
