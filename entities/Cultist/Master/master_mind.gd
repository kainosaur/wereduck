extends CharacterBody2D

# This will be changed to whatever the player actually is
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var animator = $Sprite2D/AnimationPlayer
@onready var sprite = $Sprite2D
@onready var navigation_agent = $NavigationAgent2D
#@onready var hitbox: CollisionShape2D = $Hitbox/CollisionShape2D
@export var flipped : bool = false
@export var state_machine : StateMachine
@export var health : Health

# this is the offset of the punch sprites
# because they are offcentered
@export var sprite_punch_offset: int = 50
# how far cultist is knockedback
@export var knockback_distance: int = 60
# distance x and y player must be under for attack to occur
@export var distance_from_player_x : int = 160
@export var distance_from_player_y : int = 60
@export var movement_speed : int = 40

func _on_cultist_move_state_flipped():
	flipped = true

func _on_cultist_move_state_unflipped():
	flipped = false

func _on_hurtbox_received_damage(damage, entity_who_hit):
	if not entity_who_hit.is_in_group("enemy"):
		print("%s was hit by %s!", self, entity_who_hit)
		health.set_health(health.health - damage)
		if health.get_health() == 0: return
		state_machine.on_state_transition(state_machine.current_state, "Hit")

func _on_health_health_depleted():
	state_machine.on_state_transition(state_machine.current_state, "Death")

func _on_charge_attack():
	state_machine.on_state_transition(state_machine.current_state, "Punch")
