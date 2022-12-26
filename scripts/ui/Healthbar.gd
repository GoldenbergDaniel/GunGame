extends Control

export var max_color: Color
export var min_color: Color
export var difference_color: Color

onready var remaining_bar: TextureProgress = $RemainingBar
onready var difference_bar: TextureProgress = $DifferenceBar


func _ready() -> void:
	remaining_bar.tint_progress = max_color
	remaining_bar.modulate.a = 0

	difference_bar.tint_progress = difference_color
	difference_bar.modulate.a = 0


func _on_Timer_timeout() -> void:
	$HideTween.interpolate_property(remaining_bar, "modulate:a", 1, 0, 1)
	$HideTween.interpolate_property(difference_bar, "modulate:a", 1, 0, 1)
	$HideTween.start()


func update_fill(current_health: int, total_health: int, damage: int) -> void:
	$HideTween.stop_all()
	$UpdateTween.stop_all()

	remaining_bar.modulate.a = 1
	difference_bar.modulate.a = 1

	var percentage: float = float(current_health)/float(total_health) * 100
	remaining_bar.value = percentage

	$UpdateTween.interpolate_property(difference_bar, "value", difference_bar.value, percentage, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.2)
	$UpdateTween.start()

	$Timer.start()

	var ratio = float(damage)/float(total_health)
	var r = lerp(remaining_bar.tint_progress.r, min_color.r, ratio)
	var g = lerp(remaining_bar.tint_progress.g, min_color.g, ratio)
	var b = lerp(remaining_bar.tint_progress.b, min_color.b, ratio)
	remaining_bar.tint_progress = Color(r, g, b)

