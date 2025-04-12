extends CharacterBody2D

var speed = 200
var health = 2
@onready var enemy = $Sprite2D


func _physics_process(delta):
	var player = get_parent().get_node("Player")
	
	# Get direction toward the player
	var direction = (player.global_position - global_position).normalized()
	
	# Rotate to face the player
	if player.global_position.x < global_position.x:
		enemy.flip_h = false
	else:
		enemy.flip_h = true
	
	# Move toward the player
	velocity = direction * speed
	move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullets"):
		health -= 1
	if health <= 0:
		addHealth()
		queue_free()

func addHealth():
	if Global.playerHealth + 3 < Global.maxHealth:
		Global.playerHealth += 3
	else:
		Global.playerHealth == Global.maxHealth
