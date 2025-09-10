extends Node2D

const ROW_STEP = 10.0

@onready var block_timer := $BlockTimer

var direction := Vector2.RIGHT
var speed := 20.0
var can_change = true

func _ready():
	block_timer.timeout.connect(_on_block_timer_timeout)
	
	
func _process(delta: float) -> void:
	global_position += direction * speed * delta


func change_direction():
	print("prepare direction change")
	if block_timer.time_left > 0:
		if not can_change:
			return
	print("Direction changed")
	direction = Vector2.LEFT if direction == Vector2.RIGHT else Vector2.RIGHT
	global_position.y += ROW_STEP
	
	can_change = false
	block_timer.start()
	
func _on_block_timer_timeout():
	can_change = true
