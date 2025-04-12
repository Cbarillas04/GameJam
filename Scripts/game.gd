extends Node2D

var enemy_scene = preload("res://Enemy.tscn")
var enemy_instance = enemy_scene.instantiate()

func _ready():
	var screen_size = get_viewport_rect().size
	print("Screen size:", screen_size)
	randomize()
	$Timer.wait_time = 2.0
	$Timer.timeout.connect(_on_Timer_timeout)
	$Timer.start()
	
func _on_Timer_timeout():
	spawnEnemy(getRandomEdgePosition())

func spawnEnemy(vector):
	var enemy = enemy_scene.instantiate()
	enemy.add_to_group("enemy")
	enemy.global_position = vector
	add_child(enemy)

func getRandomEdgePosition():
	var margin = 100 # Area past border it can spawn in
	var side = randi() % 4  # Randomize direction
	
	# Cases depending on outcome of side
	match side:
		0: return Vector2(randf_range(0, 1152), - margin) #Up
		1: return Vector2(1152 + margin, randf_range(0, 648)) #Right
		2: return Vector2(randf_range(0, 1152), 648 + margin) #Down
		3: return Vector2(-margin, randf_range(0, 648)) #Left
