extends State

@export var cultist : CharacterBody2D
@export var animator : AnimationPlayer
@export var hitbox : CollisionShape2D

func enter():
	punch()

func punch():
	cultist.velocity = Vector2(0, 0)
	hitbox.disabled = false
	animator.play("punch")
	if cultist.flipped == true:
		hitbox.position.x = abs(hitbox.position.x)
	else:
		hitbox.position.x = -abs(hitbox.position.x)
	await animator.animation_finished
	print("Punch done")
	hitbox.disabled = true
	transition.emit(self, "Move")
	
