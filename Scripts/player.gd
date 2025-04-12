extends CharacterBody2D


var movespeed = 400

@onready var Character = $CollisionShape2D/Character

func _ready():
	pass
	
func _physics_process(delta):
	var motion = Vector2()
	#Movement Directions
	if Input.is_action_pressed("Up"):
		motion.y -= 1
	if Input.is_action_pressed("Down"):
		motion.y += 1
	if Input.is_action_pressed("Right"):
		motion.x += 1
	if Input.is_action_pressed("Left"):
		motion.x -= 1
	
	motion = motion.normalized()
	velocity = motion * movespeed
	move_and_slide()
	
	
func _process(delta):
	var mouse_pos = get_global_mouse_position()

	if mouse_pos.x < global_position.x:
		Character.flip_h = true
	else:
		Character.flip_h = false
		
func hit():
	pass
