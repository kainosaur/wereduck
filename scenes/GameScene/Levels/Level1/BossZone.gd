extends Area2D

@onready var num_enemies = $EnemyHolder.get_child_count()
@onready var enemy_basic = preload("res://entities/Cultist/Basic/cultist_basic.tscn")
@onready var enemy_projectile = preload("res://entities/Cultist/Projectile/cultist_projectile.tscn")
@onready var boss = preload("res://entities/Cultist/Master/master_mind.tscn")
@onready var wave_num: = 0
@onready var zone_active = false
@onready var zone_complete = false
@onready var level = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_body_entered(body):
	if zone_complete:
		pass
	elif body == $"../Player":
		print("test") #zone activates once player steps inside
		zone_active = true
	
func next_wave():
	if num_enemies == 0: #goes to next wave
		wave_num += 1
		if wave_num == 3:
			boss = boss.instantiate()
			boss.position = $EnemySpawn3.position
			$EnemyHolder.add_child(boss)
		elif wave_num == 4:
			zone_active = false
			zone_complete = true
		else:
			prepare_spawn("basic", 3, 3)
			prepare_spawn("proj", 1, 1) #replace w/ proj in final

		
func prepare_spawn(type, mult, mob_spawns):
	var mob_amount = wave_num*mult
	var mob_wait_time = 2.0
	var mob_spawn_rounds = ceil(mob_amount/mob_spawns)
	spawn_enemies(type, mob_spawn_rounds, mob_wait_time)

func spawn_enemies(type, mob_spawn_rounds, mob_wait_time):
	if type == "basic":
		if mob_spawn_rounds >= 1:
			for i in mob_spawn_rounds:
				var basic1 = enemy_basic.instantiate()
				var basic2 = enemy_basic.instantiate()
				var basic3 = enemy_basic.instantiate()
				basic1.position = $EnemySpawn.position
				basic2.position = $EnemySpawn2.position
				basic2.position = $EnemySpawn3.position
				$EnemyHolder.add_child(basic1)
				$EnemyHolder.add_child(basic2)
				$EnemyHolder.add_child(basic3)
				mob_spawn_rounds -= 1
				await get_tree().create_timer(mob_wait_time).timeout
				
	if type == "proj":
		if mob_spawn_rounds >= 1:
			for i in mob_spawn_rounds:
				var proj = enemy_projectile.instantiate()
				proj.position = $EnemySpawn4.position
				$EnemyHolder.add_child(proj)
				mob_spawn_rounds -= 1
				await get_tree().create_timer(mob_wait_time).timeout
			
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if zone_active:
		num_enemies = $EnemyHolder.get_child_count()
		print("wave_num ", wave_num, " num enemies ", num_enemies)
		next_wave()
		
	if zone_complete:
		zone_active=false
		level.lvl_complete = true
		



