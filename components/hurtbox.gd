class_name Hurtbox
extends Area2D


signal received_damage(damage: int)

@export var health: Health

func _ready():
	connect('area_entered', _on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Hitbox and area.is_in_group("enemy"):
		var hitbox = area as Hitbox
		if hitbox and hitbox.owner:
			#Collect hitbox data
			var damage = hitbox.damage
			#Apply damage
			if damage > 0:
				health.health -= hitbox.damage
				received_damage.emit(hitbox.damage)
