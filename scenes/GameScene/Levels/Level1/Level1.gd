extends Node2D

@onready var pause_menu = $Player/CanvasLayer/PlayerUi/PauseMenu
@onready var player = get_tree().get_first_node_in_group("Player")
var paused = false
var lvl_complete = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("enter"):
		pause()
	if !player:
		var game_over_screen = load("res://scenes/LoseScreen/LoseScreen.tscn")
		var game_over_screen_instance = game_over_screen.instantiate()
		add_child(game_over_screen_instance)
	if lvl_complete:
		var complete_menu = load("res://scenes/GameScene/Levels/Level1/WinScreen1.tscn")
		complete_menu = complete_menu.instantiate()
		$Player/CanvasLayer/PlayerUi.add_child(complete_menu)
		
		
	
func pause():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
		paused = !paused
	else:
		pause_menu.show()
		Engine.time_scale = 0
		paused = !paused

