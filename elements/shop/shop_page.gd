extends CanvasLayer

func _on_close_pressed():
	get_node("Anim").play("transOut")
	get_tree().paused = false
