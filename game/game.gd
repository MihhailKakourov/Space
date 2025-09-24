extends Node2D

@onready var word: Node = $Word
@onready var player: CharacterBody2D = $Player

var current_word_node: Node = null

var bullet_scene = preload("res://elements/bullet/bullet.tscn")
const GAME_OVER_SCENE = preload("res://elements/game_over/game_over.tscn")

func _ready():
	Events.hp_changed.connect(func(hp: int): check_game_over())
	
	add_to_group("game")
	spawn_new_word()
	
func check_game_over():
	if Globals.hp <= 0:
		add_child(GAME_OVER_SCENE.instantiate())

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		if current_word_node and current_word_node.completed:
			shoot()
	elif event is InputEventKey and event.pressed and not event.echo:
		var char = event.as_text()
		if current_word_node != null and char.length() == 1:
			current_word_node.check_input(char)

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = player.global_position

	var enemies = get_tree().get_nodes_in_group("Enemies")
	var space_state: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var nearest: Node2D = null
	var min_dist: float = INF

	for e in enemies:
		if not is_instance_valid(e):
			continue

		var d: float = player.global_position.distance_to(e.global_position)

		var query := PhysicsRayQueryParameters2D.create(player.global_position, e.global_position)
		query.exclude = [player]
		query.collide_with_areas = true
		query.collide_with_bodies = true

		var hit: Dictionary = space_state.intersect_ray(query)

		if hit.size() > 0 and hit["collider"] == e:
			if d < min_dist:
				min_dist = d
				nearest = e

	if nearest:
		bullet.direction = (nearest.global_position - player.global_position).normalized()
	else:
		bullet.direction = Vector2.UP

	add_child(bullet)


#	spawn_new_word()

func spawn_new_word():
	if current_word_node != null:
		current_word_node.queue_free()

	var scene = load("res://elements/word/word.tscn")
	current_word_node = scene.instantiate()

	add_child(current_word_node)
	current_word_node.set_word(word.get_random_word())
	current_word_node.set_player(player)

	current_word_node.connect("word_failed", Callable(self, "_on_word_failed"))
	current_word_node.connect("word_completed", Callable(self, "_on_word_completed"))

func _on_word_failed():
	var timer = get_tree().create_timer(0.5)
	await timer.timeout
	spawn_new_word()

func _on_word_completed():
	pass
