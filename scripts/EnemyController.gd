extends KinematicBody2D

var gravity: float = 8
var motion: Vector2


func _ready() -> void:
	var _err = $Hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")


func _process(_delta) -> void:
	if $Health.is_zero():
		queue_free()


func _physics_process(delta) -> void:
	motion.y += gravity * delta * 60
	motion = move_and_slide(motion, Vector2.UP)


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		take_damage(area.damage)


func take_damage(var damage: int) -> void:
	$Health.subtract(damage)
