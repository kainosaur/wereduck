extends State


@export var animator : AnimationPlayer

var input_vector: Vector2

func enter():
	animator.play("hurt")
	await animator.animation_finished
	transition.emit(self, "PlayerIdleState")
	

