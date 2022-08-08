extends Area2D

var speed: int
var damage: int

var EFFECT: Resource = preload("res://scenes/effects/BulletParticles.tscn")


func _ready() -> void:
	var _err = connect("body_shape_entered", self, "_on_Bullet_body_shape_entered")


func _process(_delta) -> void:
	if $Timer.is_stopped():
		queue_free()


func _physics_process(delta) -> void:
	self.position += Vector2(1, 0).rotated(self.rotation) * speed * delta 


func _on_Bullet_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	var effect = EFFECT.instance()
	effect.position = self.position
	get_node("/root/World").add_child(effect)
	queue_free()
