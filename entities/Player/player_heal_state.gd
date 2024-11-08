extends State


@export var animator : AnimationPlayer

var input_vector: Vector2

func enter():
	animator.play("heal")
	await animator.animation_finished
	transition.emit(self, "PlayerIdleState")
	

