extends Control

onready var bar: TextureProgress = $Bar


func _ready() -> void:
	Signals.connect("cooldown_activated", self, "on_Cooldown_activated")

	bar.modulate.a = 0


func on_Cooldown_activated(duration: float) -> void:
	$HideTween.stop_all()
	$UpdateTween.stop_all()

	bar.modulate.a = 1

	$UpdateTween.interpolate_property(bar, "value", duration, 0, duration/100)
	$UpdateTween.start()
	$UpdateTween.interpolate_callback(self, 0, "start_timer")

	bar.max_value = duration


func _on_Timer_timeout():
	$HideTween.interpolate_property(bar, "modulate:a", 1, 0, 0.5)
	$HideTween.start()


func start_timer():
	$Timer.start()
