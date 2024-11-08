extends Area2D

@onready var player = get_tree().get_nodes_in_group("Player")[0]

var direction : Vector2
var speed : float = 10.0

func _ready():
	add_to_group("Fireball")
	var player_pos = player.get_node("Hurtbox").global_position
	var fireball_pos = self.global_position
	direction = (player_pos - fireball_pos).normalized()

func _process(delta):
	global_position += direction * speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
