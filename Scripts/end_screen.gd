extends Control

@onready var score = $Score

func _ready():
	score.text = "Score: " + str(Global.score)
	Global.score = 0

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		start_game()

func start_game():
	get_tree().change_scene_to_file("res://start_screen.tscn")
