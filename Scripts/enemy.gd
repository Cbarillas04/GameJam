extends CharacterBody2D

var player_in_area = false
var speed = 75
var health = 2

@onready var cooldown_timer = $DamageCooldown
@onready var enemy = $Enemy
@onready var walkAnim = $Enemy/Walk


func _physics_process(delta):
	var player = get_parent().get_node("Player")
	walkAnim.play("Walk")
	
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
	if body.name == "Player":
		player_in_area = true
		if cooldown_timer.time_left > 0.0:
			return
		cooldown_timer.start()
		
	if body.is_in_group("bullets"):
		health -= 1
		if health <= 0:
			addHealth()
			queue_free()

func addHealth():
	if Global.playerHealth + 3 < Global.maxHealth:
		Global.playerHealth += 3
	else:
		Global.playerHealth = Global.maxHealth
	Global.health_changed.emit()
	
func _on_DamageCooldown_timeout():
	print("pass")
	if player_in_area:
		Global.playerHealth -= 1
		Global.health_changed.emit()
		cooldown_timer.start()  # Loop it again if player still inside
