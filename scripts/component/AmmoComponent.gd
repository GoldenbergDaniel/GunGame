extends Node
class_name AmmoComponent

export var total_ammo: int
var mag_size: int
var ammo_in_mag: int
var ammo_in_reserve: int


func _ready() -> void:
	ammo_in_reserve = total_ammo


func add(count: int) -> void:
	total_ammo += count

	Signals.emit_signal("ammo_updated", ammo_in_mag, ammo_in_reserve)


func subtract_one() -> void:
	ammo_in_mag -= 1
	if ammo_in_mag < 0:
		ammo_in_mag = 0

	Signals.emit_signal("ammo_updated", ammo_in_mag, ammo_in_reserve)


func reload() -> void:
	if ammo_in_reserve >= mag_size - ammo_in_mag:
		ammo_in_reserve -= mag_size - ammo_in_mag
		ammo_in_mag = mag_size
	else:
		ammo_in_mag += ammo_in_reserve
		ammo_in_reserve = 0

	Signals.emit_signal("ammo_updated", ammo_in_mag, ammo_in_reserve)


func is_zero() -> bool:
	return total_ammo == 0


func is_zero_in_mag() -> bool:
	return ammo_in_mag == 0
