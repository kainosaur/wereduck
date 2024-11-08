class_name Hitbox
extends Area2D

#Stores damage of character, different damage values may be set in the inspector;
#If different attacks should have different damage values, you can create a 
#new track in each attack's animation in AnimationPlayer, and add a key with the
#damage value that attack should have.
@export var damage: int = 1 : set = set_damage, get = get_damage

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage
	



