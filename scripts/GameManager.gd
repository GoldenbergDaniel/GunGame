extends Node

func _process(_delta):
	if Input.is_action_pressed("ui_exit"):
		get_tree().quit()
