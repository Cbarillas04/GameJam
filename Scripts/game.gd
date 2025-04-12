extends Node2D

var enemy_scene = preload("res://Enemy.tscn")
var enemy_instance = enemy_scene.instantiate()

func _ready():
	var enemy = enemy_scene.instantiate()
	enemy.global_position = get_random_edge_position()
	add_child(enemy)
	


func get_random_edge_position():
	var margin = 25 # Area past border it can spawn in
	var side = randi() % 4  # Randomize direction
	
	# Cases depending on outcome of side
	match side:
		0: return Vector2(randf_range(0, 1152), -margin) #Up
		1: return Vector2(1152 + margin, randf_range(0, 648)) #Right
		2: return Vector2(randf_range(0, 1152), 648 + margin) #Down
		3: return Vector2(-margin, randf_range(0, 1152)) #Left
