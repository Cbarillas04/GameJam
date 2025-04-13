extends Label

@onready var score = self
@onready var timer = $passiveScore

func _ready():
	timer.start()

func _process(delta):
	score.text = "Score: " + str(Global.score)
	

func _on_passive_score_timeout() -> void:
	Global.score += 10
