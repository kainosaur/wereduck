extends State

@export var animator: AnimationPlayer
@export var actor: CharacterBody2D


var combo: bool = false

func enter():
	#Fetch animation and default animation position (for hitbox)
	var animation = animator.get_animation("attack2")
	var animation_position = animation.track_get_key_value(0,0)
	#Check whether the actor is flipped (the CharacterBody2D), if so, negate the animation position
	check_flip(animation, animation_position)
	animator.play("attack2")
	await animator.animation_finished
	#Reset animation position
	reset_animation(animation, animation_position)
	if combo == false:
		transition.emit(self, "PlayerIdleState")


func _unhandled_input(event):
	if event.is_action_pressed("attack3"):
		combo = true
		await animator.animation_finished
		combo = false
		transition.emit(self, "PlayerAttack3State")
		get_viewport().set_input_as_handled()

func reset_animation(animation, position):
	animation.track_set_key_value(0, 0, position)
	
func check_flip(animation, position):
	if actor.flipped == true:
		animation.track_set_key_value(0, 0, position * Vector2(-1, 1))
