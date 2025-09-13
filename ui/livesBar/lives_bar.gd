extends HBoxContainer

const RECT_SCENE = preload("res://ui/livesBar/live_rect.tscn")

func _ready() -> void:
	Events.lives_changed.connect(update_lives)
	update_lives(Globals.lives)
	
func update_lives(lives: int):
	var diff = lives - get_parent().get_child_count()
	for i in range(abs(diff)):
		add_live() if diff > 0 else remove_live()
	
func add_live():
	get_parent().add_child(RECT_SCENE.instantiate())
	
func remove_live():
	get_parent().get_child(0).queue_free()
