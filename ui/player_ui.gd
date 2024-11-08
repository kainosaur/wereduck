extends Control

@export var actor = CharacterBody2D
@onready var health_bar = $Control/HealthBar
@onready var sanity_bar = $Control/SanityBar


func _ready():
	sanity_bar.frame = 10


func update(max_value: int, value: int, element: String):
	if element == "health":
		health_bar.frame = max_value - value
	if element == "rage":
		sanity_bar.frame = max_value - value
