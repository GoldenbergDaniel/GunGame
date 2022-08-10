extends KinematicBody2D

var gravity: float = 8
var motion: Vector2

onready var healthbar: Control = $Healthbar


func _ready() -> void:
	var _err = $Hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")


func _physics_process(delta) -> void:
	motion.y += gravity * delta * 60
	motion = move_and_slide(motion, Vector2.UP)


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		take_damage(area.damage)


func take_damage(damage: int) -> void:
	$Health.subtract(damage)
	$AnimationPlayer.play("hurt")

	healthbar.update_fill($Health.current_health, $Health.total_health, damage)

	if $Health.is_zero():
		queue_free()
