extends Node2D

var enemy_scene = preload("res://Enemy.tscn")
var enemy_scene2 = preload("res://enemy_2.tscn")

func _ready():
	randomize()
	$Timer.wait_time = 1.0
	$Timer.timeout.connect(_on_Timer_timeout)
	$Timer.start()

#After xx:xx time, call spawnEnemy
func _on_Timer_timeout():
	spawnEnemy(getRandomEdgePosition())

# Spawn an single enemy
func spawnEnemy(position: Vector2):
	var temp = randi() % 3
	var enemy = null
	if temp in [0, 1]:
		enemy = enemy_scene.instantiate()
	elif temp == 2:
		enemy = enemy_scene2.instantiate()
	
	enemy.add_to_group("enemy")
	enemy.global_position = position
	add_child(enemy)
	
	# Debug circle
	#var debug = ColorRect.new()
	#debug.color = Color(1, 0, 0, 0.5)
	#debug.size = Vector2(10, 10)
	#debug.global_position = position
	#add_child(debug)
	
#Find spawn point for enemy
func getRandomEdgePosition() -> Vector2:
	var margin = 50
	var camera = get_viewport().get_camera_2d()

	# Fallback if there's no camera yet
	if camera == null:
		return Vector2.ZERO
		
		#Adjust to fit screen size for all
	var screen_size = get_viewport_rect().size
	var cam_pos = camera.global_position
	var half_size = screen_size * 0.5

	var left = cam_pos.x - half_size.x - margin
	var right = cam_pos.x + half_size.x + margin
	var top = cam_pos.y - half_size.y - margin
	var bottom = cam_pos.y + half_size.y + margin
	
	var side = randi() % 4
	
	#Cases for depedning on the random, decides where the enemy spawn comes from
	match side:
		0: return Vector2(randf_range(left, right), top)     # Top
		1: return Vector2(right, randf_range(top, bottom))   # Right
		2: return Vector2(randf_range(left, right), bottom)  # Bottom
		3: return Vector2(left, randf_range(top, bottom))    # Left

	return cam_pos  # fallback center if something fails
