extends CanvasLayer



func _on_restart_button_pressed() -> void:
	print("pressed")
	get_tree().reload_current_scene()
