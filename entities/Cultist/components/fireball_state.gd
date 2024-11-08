extends State

@export var cultist : CharacterBody2D
@export var fireball_scene: PackedScene
@export var fireball_spawn : Marker2D

func enter():
	summon_fireball()
	await get_tree().create_timer(0.75).timeout
	transition.emit(self, "Move")

func summon_fireball():
	var fireball = fireball_scene.instantiate()
	fireball.position = fireball_spawn.position
	owner.add_child(fireball)
	print("Spawned Fireball")
