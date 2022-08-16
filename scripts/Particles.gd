extends CPUParticles2D

onready var timer: Timer = $Timer


func _ready() -> void:
	self.emitting = true


func _on_Timer_timeout() -> void:
	queue_free()
