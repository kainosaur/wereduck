extends State

@export var animator: AnimationPlayer
@export var actor: CharacterBody2D


func enter():
	#Fetch animation and default animation position (for hitbox)
	var animation = animator.get_animation("wereduckattack3")
	var animation_position = animation.track_get_key_value(0,0)
	#Check whether the actor is flipped (the CharacterBody2D), if so, negate the animation position
	check_flip(animation, animation_position)
	animator.play("wereduckattack3")
	await animator.animation_finished
	#Reset animation position
	reset_animation(animation, animation_position)
	transition.emit(self, "PlayerIdleState")


func reset_animation(animation, position):
	animation.track_set_key_value(0, 0, position)
	
func check_flip(animation, position):
	if actor.flipped == true:
		animation.track_set_key_value(0, 0, position * Vector2(-1, 1))
