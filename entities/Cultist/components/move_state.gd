extends State

@onready var player = get_tree().get_nodes_in_group("Player")[0]
@export var cultist : CharacterBody2D
@export var animator : AnimationPlayer
@export var sprite : Sprite2D
@export var navigation_agent : NavigationAgent2D

signal flipped
signal unflipped

func enter():
	print("Entering Move State")
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	if not player:
		return
	var player_pos = player.get_node("Hurtbox").global_position
	set_movement_target(Vector2(player_pos.x + cultist.distance_from_player_x, player_pos.y))

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func check_if_velocity_zero():
	if not cultist.velocity.is_zero_approx():
		animator.play("walk")
	elif animator.get_current_animation() == "walk":
		animator.stop()

# How to make punch
# this get's called after navigation_agent is finished
# for now play punch
# enable the hitbox
# then disable the hitbox

func change_to_charge():
	animator.stop()
	transition.emit(self, "Charge")
	return

func physics_update(_delta):
	if not player:
		return
	check_if_velocity_zero()
	if navigation_agent.is_navigation_finished():
		change_to_charge()
	var player_pos = player.get_node("Hurtbox").global_position
	var player_target = cultist.distance_from_player_x
	
	# Check if player X compared to cultist is negative or positive
	# Change flipped state based on this
	if player_pos.x > cultist.global_position.x:
		sprite.flip_h = true
		emit_signal("flipped")
		set_movement_target(Vector2(player_pos.x - player_target, player_pos.y))
	else:
		sprite.flip_h = false
		emit_signal("unflipped")
		set_movement_target(Vector2(player_pos.x + player_target, player_pos.y))
	
	if is_close_to_player(player_pos):
		change_to_charge()
	var current_cultist_position: Vector2 = cultist.global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	cultist.velocity = current_cultist_position.direction_to(next_path_position) * cultist.movement_speed

	cultist.move_and_slide()

func is_close_to_player(player_pos: Vector2) -> bool:
	var cultist_pos = cultist.position
	var distance_y = cultist.distance_from_player_y
	var distance_x = cultist.distance_from_player_x
	if abs(player.position.y - cultist_pos.y) <= distance_y:
		if !cultist.flipped and player_pos.x <= cultist_pos.x and abs(player_pos.x - cultist_pos.x) <= distance_x:
			return true
		elif cultist.flipped and player_pos.x >= cultist_pos.x and abs(player_pos.x - cultist_pos.x) <= distance_x:
			return true
	return false
