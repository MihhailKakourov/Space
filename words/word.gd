extends Node2D

@onready var label: RichTextLabel = $Label

signal word_failed
signal word_completed

var word: String = ""
var index: int = 0
var completed: bool = false

func set_word(new_word: String):
	word = new_word
	index = 0
	completed = false
	update_display()

func check_input(char: String):
	if completed:
		return

	char = char.to_lower()
	var expected = word[index].to_lower()

	if char == expected:
		index += 1
		update_display()
		if index >= word.length():
			completed = true
			emit_signal("word_completed")
	else:
		show_error()
		emit_signal("word_failed")

func update_display():
	var display_text = ""
	for i in range(word.length()):
		var letter = word[i]
		if i < index:
			display_text += "[color=green]" + letter + "[/color]"
		else:
			display_text += letter
	label.bbcode_text = display_text

func show_error():
	var display_text = ""
	for i in range(word.length()):
		display_text += "[color=red]" + word[i] + "[/color]"
	label.bbcode_text = display_text
	index = 0
