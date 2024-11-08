extends State

@export var animator : AnimationPlayer

func enter():
	animator.play("spawn")
	await animator.animation_finished
	transition.emit(self, "Move")
