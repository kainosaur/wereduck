extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animator = $AnimationPlayer
@onready var sprite = $Icon
@onready var hitbox = $Hitbox/CollisionShape2D
@onready var rage_deplete_timer = $RageTimer
@onready var player_ui = $CanvasLayer/PlayerUi

@export var is_wereduck = false
@export var flipped: bool = false
@export var health: Health
@export var rage: Rage

var health_decreased = false
var health_increased = false
var dead = false
var stored_health: int
var max_health: int = 10
var rage_depleted: bool

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _on_player_move_state_flipped():
	flipped = true


func _on_player_move_state_unflipped():
	flipped = false


func _on_health_health_depleted():
	dead = true


func _on_hurtbox_received_damage(damage, entity_who_hit):
	if entity_who_hit.is_in_group("Enemy"):
		health.health -= damage
		player_ui.update(max_health, health.health, "health")
		health_decreased = true
		if entity_who_hit.is_in_group("Fireball"):
			entity_who_hit.queue_free()
		await get_tree().create_timer(0.1).timeout
		health_decreased = false


func _on_player_transform_state_transformed():
	if is_wereduck == true:
		is_wereduck = false
		stop_rage_deplete()
		health.max_health = max_health 
		health.health = stored_health
		player_ui.update(max_health, health.health, "health")
	elif rage.rage > 0:
		is_wereduck = true
		start_rage_deplete()
		if not health.health <= 1:
			stored_health = health.health
			health.health -= health.health/2 
			health.max_health = health.health
			player_ui.update(max_health, health.health, "health")


func _on_hurtbox_received_health(value):
	health_increased = true
	health.health -= value
	player_ui.update(max_health, health.health, "health")
	await get_tree().create_timer(0.15).timeout
	health_increased = false

func stop_rage_deplete():
	rage_deplete_timer.stop()

func start_rage_deplete():
	rage_deplete_timer.start()

func _on_hitbox_area_entered(area):
	calculate_rage()

func calculate_rage():
	if not is_wereduck:
		rage.rage += 1
		rage_depleted = false
		player_ui.update(rage.max_rage, rage.rage, "rage")

func _on_rage_timer_timeout():
	rage.rage -= 1
	player_ui.update(rage.max_rage, rage.rage, "rage")


func _on_rage_rage_depleted():
	rage_depleted = true
