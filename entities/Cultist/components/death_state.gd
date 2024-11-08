extends State

@export var cultist : CharacterBody2D
@export var animator : AnimationPlayer

func enter():
	animator.play("die")
	await animator.animation_finished
	cultist.queue_free()
