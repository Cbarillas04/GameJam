extends CharacterBody2D

var movespeed = 200

@onready var Character = $CollisionShape2D/Character
@onready var walkAnim = $CollisionShape2D/Character/Walk

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
	
	if motion != Vector2.ZERO:
		if not walkAnim.is_playing():
			walkAnim.play("Walk")
	else:
		walkAnim.stop()
	
	
func _process(delta):
	var mouse_pos = get_global_mouse_position()

	if mouse_pos.x < global_position.x:
		Character.flip_h = true
	else:
		Character.flip_h = false
		

func take_damage(amount):
	Global.playerHealth -= amount
	Global.playerHealth = clamp(Global.playerHealth, 0, Global.maxHealth)
	emit_signal("health_changed", Global.playerHealth)
	
