extends Node2D

const ROW_STEP = 10.0

@onready var block_timer := $BlockTimer

var direction := Vector2.RIGHT
var speed := 20.0

func _process(delta: float) -> void:
	global_position += direction * speed * delta


func change_direction():
	print("prepare direction change")
	if block_timer.time_left > 0:
		return
	print("Direction changed")
	direction = Vector2.LEFT if direction == Vector2.RIGHT else Vector2.RIGHT
	global_position.y += ROW_STEP
	block_timer.start()
