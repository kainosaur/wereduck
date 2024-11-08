class_name Rage
extends Node


signal rage_changed(diff: int)
signal rage_depleted


@export var max_rage: int = 10 : set = set_max_rage, get = get_max_rage


@onready var rage: int = 0 : set = set_rage, get = get_rage


func set_max_rage(value: int):
	var clamped_value = 1 if value <= 0 else value
	
	if not clamped_value == rage:
		var difference = clamped_value - max_rage
		max_rage = value
		
		if rage > max_rage:
			rage = max_rage
	

func get_max_rage() -> int:
	return max_rage



func set_rage(value: int):
	var clamped_value = clampi(value, 0, max_rage)
	
	if clamped_value != rage:
		var difference = clamped_value - rage
		rage = clamped_value
		rage_changed.emit(difference)
		
		if rage <= 0:
			rage_depleted.emit()


func get_rage():
	return rage

