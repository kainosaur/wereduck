extends State

@export var cultist : CharacterBody2D
@export var animator : AnimationPlayer
@export var sprite : Sprite2D

signal attack

func enter():
	charge()

func charge():
	animator.play("charge")
	await animator.animation_finished
	transition.emit(self, "Punch")
