extends Node

signal health_changed
signal playerDied

#@onready var scoreText = 

var velocity = Vector2()
var playerHealth = 20
var maxHealth = 20
var score = 0

func _process(delta):
	if playerHealth * 100 / maxHealth <= 45:
		die()

func die():
	print("Player has died!")
	velocity = Vector2.ZERO
	
	# Load the start screen
	get_tree().change_scene_to_file("res://end_screen.tscn")
	# Reset values
	playerHealth = maxHealth
	#score = 0
