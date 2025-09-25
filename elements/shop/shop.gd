extends Area2D

@onready var shop = get_node("Shop")  # путь к CanvasLayer магазина

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		shop.open_shop()
