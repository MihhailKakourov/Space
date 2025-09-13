extends CanvasLayer

@onready var points_label = $MarginContainer/VBoxContainer/HBoxContainer/Label

func _ready() -> void:
	Events.points_changed.connect(update_points)
	
func update_points(points: int):
	if is_instance_valid(points_label):
		points_label.text = str(points)
