extends CanvasLayer

onready var fps_display: RichTextLabel = $FPS


func _process(_delta):
	fps_display.text = "FPS: " + str(Engine.get_frames_per_second())
