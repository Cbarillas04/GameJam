extends Control

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		start_game()

func start_game():
	get_tree().change_scene_to_file("res://game.tscn")
