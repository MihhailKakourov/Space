extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().paused = true
		get_node("Shop/Anim").play("transIn")
