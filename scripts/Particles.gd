extends CPUParticles2D

var timer: Timer


func _ready():
	self.emitting = true
	timer = $Timer
	timer.start()
	

func _process(_delta):
	if timer.is_stopped():
		print("Stop")
		queue_free()
