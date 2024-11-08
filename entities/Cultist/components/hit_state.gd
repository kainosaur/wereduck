extends State

@export var cultist : CharacterBody2D
@export var animator : AnimationPlayer
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func enter():
	cultist.velocity = Vector2(0,0)
	knockback()
	animator.play("hurt")
	# Not sure why, but this is needed
	# Or else I can't transition for some reason lol
	await animator.animation_finished
	transition.emit(self, "Move")

func knockback():
	if cultist.position.x > player.position.x:
		cultist.velocity.x = cultist.knockback_distance
	elif cultist.position.x < player.position.x:
		cultist.velocity.x = -cultist.knockback_distance

func physics_update(_delta):
	cultist.move_and_slide()
