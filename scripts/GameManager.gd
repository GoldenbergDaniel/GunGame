extends Node


func _ready() -> void:
	var os_name = OS.get_name()

	if os_name == "Windows":
		OS.window_size = Vector2(1280, 720)
		# OS.window_position = (OS.get_screen_size()*0.5 - OS.get_window_size()*0.5)
	elif os_name == "OSX":
		OS.window_size = Vector2(2240, 1260)
		# OS.window_position = (OS.get_screen_size()*0.5 - OS.get_window_size()*0.5)

	OS.window_position = (OS.get_screen_size()*0.5 - OS.get_window_size()*0.5)


func _process(_delta) -> void:
	if Input.is_action_pressed("ui_exit"):
		get_tree().quit()
