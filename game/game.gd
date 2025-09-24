extends Node2D

@onready var word_manager: Node = $WordManager
@onready var player: CharacterBody2D = $Player
var current_word_node: Node = null

var bullet_scene = preload("res://words/bullet.tscn")

func _ready():
	add_to_group("game") # чтобы пуля могла вызвать spawn_new_word
	spawn_new_word()

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_accept"): # пробел
		if current_word_node and current_word_node.completed:
			shoot()
	elif event is InputEventKey and event.pressed and not event.echo:
		var char = event.as_text()
		if current_word_node != null and char.length() == 1:
			current_word_node.check_input(char)

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = player.global_position

	# ищем ближайшего врага
	var enemies = get_tree().get_nodes_in_group("Enemies")
	if enemies.size() > 0:
		var nearest = enemies[0]
		var min_dist = player.global_position.distance_to(nearest.global_position)
		for e in enemies:
			var d = player.global_position.distance_to(e.global_position)
			if d < min_dist:
				min_dist = d
				nearest = e
		bullet.direction = (nearest.global_position - player.global_position).normalized()
	else:
		bullet.direction = Vector2.UP # если врагов нет — вверх

	add_child(bullet)

	# сбрасываем слово после выстрела
	spawn_new_word()

func spawn_new_word():
	if current_word_node != null:
		current_word_node.queue_free()

	var scene = load("res://words/word.tscn")
	current_word_node = scene.instantiate()

	add_child(current_word_node)
	current_word_node.set_word(word_manager.get_random_word())
	current_word_node.set_player(player)

	current_word_node.connect("word_failed", Callable(self, "_on_word_failed"))
	current_word_node.connect("word_completed", Callable(self, "_on_word_completed"))

func _on_word_failed():
	var timer = get_tree().create_timer(0.5)
	await timer.timeout
	spawn_new_word()

func _on_word_completed():
	# теперь ждём пробела, чтобы выстрелить
	pass
