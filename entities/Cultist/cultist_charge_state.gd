extends State

@export var cultist : CharacterBody2D
@export var animator : AnimationPlayer
@export var sprite : Sprite2D

func enter():
	charge_punch()

func charge_punch():
	animator.play("charge_punch")
	if cultist.flipped == true:
		# sprite moves, meaning I have to make the position
		# have an offset
		sprite.position.x = 50
	else:
		sprite.position.x = -50

	await get_tree().create_timer(0.5).timeout
	transition.emit(self, "Punch")