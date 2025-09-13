extends CanvasLayer

@onready var points_labal = $MarginContainer/VBoxContainer/HBoxContainer/Label

func _ready() -> void:
	Events.points_changed.connect(update_points)
	
func update_points(poins: int):
	points_labal.text = str(poins)
