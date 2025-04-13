# health_bar.gd
extends TextureProgressBar

func _ready():
	Global.health_changed.connect(update)
	update()

func update():
	value = Global.playerHealth * 100 / Global.maxHealth
	print(Global.playerHealth)
