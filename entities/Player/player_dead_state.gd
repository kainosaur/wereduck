extends State

@export var actor : CharacterBody2D
@export var animator : AnimationPlayer



func enter():
	animator.play("die")
	await animator.animation_finished
	actor.queue_free()


