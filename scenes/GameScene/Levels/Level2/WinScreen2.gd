extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	get_tree().quit()
	

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Menus/MainMenu/MainMenuWithAnimations.tscn")

func _on_continue_button_pressed():
	
	get_tree().change_scene_to_file("res://scenes/EndCredits/EndCredits.tscn")
	