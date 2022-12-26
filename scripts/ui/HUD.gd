extends Control

onready var health_ui: RichTextLabel = $Health
onready var ammo_ui: RichTextLabel = $Ammo


func _ready() -> void:
	Signals.connect("health_updated", self, "on_Health_updated")
	Signals.connect("ammo_updated", self, "on_Ammo_updated")


func on_Health_updated(current_health: int):
	health_ui.text = "Health: " + str(current_health)


func on_Ammo_updated(ammo_in_mag: int, ammo_in_reserve: int):
	ammo_ui.text = "Ammo: " + str(ammo_in_mag) + "/" + str(ammo_in_reserve)
