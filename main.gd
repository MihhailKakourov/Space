extends Node2D

var score := 0
@onready var label: Label = $CanvasLayer/Label

func _ready() -> void:
	label.text = "Score: %d" % score

func _on_coin_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		score += 1
		label.text = "Score: %d" % score
		$Coin.queue_free()  # монетку убратьplace with function body.
