extends Node
class_name InvulnTimer

#Time til invulnerable will determine the time invulnerability will start for a 
#character after the character was last hit
#Time invulnerable will determine the time invulnerability will last for a character
#Instance an InvulnTimer as a child node of a Hurtbox and set export values to use
@export var time_til_invulnerable: float
@export var time_invulnerable: float
var hurtbox: Hurtbox
var collision_shape: CollisionShape2D

func _ready():
	assert(get_parent() is Hurtbox, "ERROR: Parent node must be a Hurtbox object.")
	hurtbox = get_parent()


func run():
	collision_shape = hurtbox.collision_shape
	await get_tree().create_timer(time_til_invulnerable).timeout
	collision_shape.set_deferred("disabled", true)
	await get_tree().create_timer(time_invulnerable).timeout
	collision_shape.set_deferred("disabled", false)


