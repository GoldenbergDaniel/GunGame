extends Node


func _ready() -> void:
	var os_name = OS.get_name()
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()

	if os_name == "OSX":
		OS.window_size = Vector2(1920, 1080)
	elif os_name == "Windows":
		OS.window_size = Vector2(1280, 720)

	OS.window_position = (screen_size*0.5 - window_size*0.5)


func _process(_delta) -> void:
	if Input.is_action_pressed("ui_exit"):
		get_tree().quit()
