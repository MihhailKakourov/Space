extends CanvasLayer

@onready var hp_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/HP

func _ready() -> void:
	Events.hp_changed.connect(update_hp)
	
func update_hp(hp: int):
	hp_label.text = str(hp)
