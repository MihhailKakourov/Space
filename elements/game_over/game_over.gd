extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	print("pressed")
	_restart_stats()
	get_tree().reload_current_scene()


func _restart_stats() -> void:
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		if is_instance_valid(enemy):
			enemy.queue_free()
	Globals.hp = 100
	Globals.coin = 0
