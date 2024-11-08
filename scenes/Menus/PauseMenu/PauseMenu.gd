extends Control

@onready var level = $"../../../.."
# Called when the node enters the scene tree for the first time.

func _on_restart_pressed():
	level.pause()
	get_tree().reload_current_scene()
	



func _on_resume_pressed():
	level.pause()



func _on_main_menu_pressed():
	#get_tree().change_scene_to_file()
	pass
	


func _on_quit_pressed():
	get_tree().quit()
