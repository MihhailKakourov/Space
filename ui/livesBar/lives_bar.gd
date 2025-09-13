extends HBoxContainer

const RECT_SCENE = preload("res://ui/livesBar/live_rect.tscn")

func _ready() -> void:
	Events.lives_changed.connect(update_lives)
	update_lives(Globals.lives)
	
func update_lives(lives: int):
	if lives < 0:
		return
	#Сначала очищаем лишние или добавляем недостающие
	var diff = lives - get_child_count() #считаем детей в HBoxContainer
	for i in range(abs(diff)):
		if diff > 0:
			add_live()
		else:
			remove_live()
	
func add_live():
	add_child(RECT_SCENE.instantiate())
	
func remove_live():
	if get_child_count() <= 1:
		print("game over")
	get_child(0).queue_free()
