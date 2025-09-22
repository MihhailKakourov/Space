extends Node2D

@onready var word_manager: Node = $WordManager
@onready var ui: Control = $UI/MarginContainer/HBoxContainer

var current_word_node: Node = null

func _ready():
	spawn_new_word()

func _unhandled_input(event: InputEvent):
	if event is InputEventKey and event.pressed and not event.echo:
		var char = event.as_text()
		if current_word_node != null and char.length() == 1:
			current_word_node.check_input(char)

func spawn_new_word():
	if current_word_node != null:
		current_word_node.queue_free()

	var scene = load("res://words/word.tscn")
	current_word_node = scene.instantiate()
	ui.add_child(current_word_node)

	var word = word_manager.get_random_word()
	current_word_node.set_word(word)

	current_word_node.connect("word_failed", Callable(self, "_on_word_failed"))
	current_word_node.connect("word_completed", Callable(self, "_on_word_completed"))

func _on_word_failed():
	var timer = get_tree().create_timer(0.5)
	await timer.timeout
	spawn_new_word()

func _on_word_completed():
	spawn_new_word()
