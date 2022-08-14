extends Node


func _process(_delta) -> void:
	if Input.is_action_pressed("ui_exit"):
		get_tree().quit()
