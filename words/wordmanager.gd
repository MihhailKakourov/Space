extends Node

var words = {}
var category: String = "easy"

func _ready():
	load_words()

func load_words():
	var file = FileAccess.open("res://words/words.json", FileAccess.READ)
	if file:
		var data = file.get_as_text()
		words = JSON.parse_string(data)
	else:
		push_error("words.json не найден")

func get_random_word() -> String:
	if words.has(category):
		var pool = words[category]
		return pool[randi() % pool.size()]
	return ""
