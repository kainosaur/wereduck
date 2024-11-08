extends State

@export var actor : CharacterBody2D
@export var animator : AnimationPlayer
@export var sprite : Sprite2D
@export var hitbox : Hitbox
var input_vector: Vector2

func enter():
	
	#Fetch animation and default animation position (for hitbox)
	var animation = animator.get_animation("idle")
	#Check whether the actor is wereduck (the CharacterBody2D), if so, change animation texture
	check_wereduck(animation)
	animator.play("idle")
	
func physics_update(delta):
	input_vector = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	if input_vector:
		transition.emit(self, "PlayerMoveState")
	if actor.health_decreased:
		transition.emit(self, "PlayerHurtState")
	if actor.dead:
		transition.emit(self, "PlayerDeadState")
	if actor.health_increased:
		transition.emit(self, "PlayerHealState")
	if actor.rage.rage == 0 and actor.is_wereduck:
		transition.emit(self, "PlayerTransformState")

func _unhandled_input(event):
	if event.is_action_pressed("transform"):
		transition.emit(self, "PlayerTransformState")

	if actor.is_wereduck == false:
		if event.is_action_pressed("attack1"):
			transition.emit(self, "PlayerAttack1State")
		if event.is_action_pressed("attack2"):
			transition.emit(self, "PlayerAttack2State")
		if event.is_action_pressed("attack3"):
			transition.emit(self, "PlayerAttack3State")

	else:
		if event.is_action_pressed("attack1"):
			transition.emit(self, "WereduckAttack1State")
		if event.is_action_pressed("attack2"):
			transition.emit(self, "WereduckAttack2State")
		if event.is_action_pressed("attack3"):
			transition.emit(self, "WereduckAttack3State")

func check_wereduck(animation):
	if actor.is_wereduck == true:
		animation.track_set_key_value(0, 0, load("res://assets/images/Player/Wereduck_IDLE.png"))
	if actor.is_wereduck == false:
		print("player idle set")
		animation.track_set_key_value(0, 0, load("res://assets/images/Player/Player_IDLE_centered.png"))
