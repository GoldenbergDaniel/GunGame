extends Area2D

var speed: int
var damage: int

var EFFECT: Resource = preload("res://scenes/effects/BulletParticles.tscn")


func _ready() -> void:
	var _err1 = connect("area_entered", self, "_on_Bullet_area_entered")
	var _err2 = connect("body_shape_entered", self, "_on_Bullet_body_shape_entered")


func _process(_delta) -> void:
	if $Timer.is_stopped():
		queue_free()


func _physics_process(delta) -> void:
	self.position += Vector2(1, 0).rotated(self.rotation) * speed * delta 


func _on_Bullet_area_entered(_area: Area2D) -> void:
	destroy()


func _on_Bullet_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	destroy()


func destroy() -> void:
	var effect = EFFECT.instance()
	effect.position = self.position
	get_node("/root/World").add_child(effect)
	queue_free()
