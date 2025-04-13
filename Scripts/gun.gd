extends Node2D

@onready var sprite = $Gun
@onready var animationShot = $Gun/Shoot
#Setting Bullet Speed
var bullet_speed = 1500
#Loading Bullet Scene
var bullet = preload("res://bullet.tscn")


func _process(delta):
	# Get mouse position and Direction from gun to mouse
	var mouse_pos = get_global_mouse_position()  
	var to_mouse = mouse_pos - global_position

	# Rotate the parent node to face the mouse
	rotation = to_mouse.angle()

	# Flip based on the direcition o mouse
	if to_mouse.x < 0:
		sprite.flip_v = true  # Flip for left
	else:
		sprite.flip_v = false  # Flip for right
		
	if Input.is_action_just_pressed("LMB"):
		fire()
		animationShot.play("Shoot")



func fire():
	#Player Uses health pool to shoot
	Global.playerHealth -= 1
	Global.health_changed.emit()

	#Intiating Bullet scene
	var bullet_instance = bullet.instantiate()
	
	#Offsetting bullet spawn, doesn't intefere with player
	var spawn_offset = Vector2(50, 0).rotated(rotation)
	#Setting bullet with same rotation and pos + offset
	bullet_instance.global_position = global_position + spawn_offset
	bullet_instance.rotation = rotation
	bullet_instance.linear_velocity = (Vector2(bullet_speed, 0).rotated(rotation))
	
	bullet_instance.add_to_group("bullets")
	#Spawn Bullet in
	get_tree().get_root().call_deferred("add_child", bullet_instance)
