extends CharacterBody2D

@onready var reycast_left := $RayCast2DLeft
@onready var reycast_right := $RayCast2DRight

func _physics_process(delta: float) -> void:
	if reycast_left.is_colliding() or reycast_right.is_colliding():
		get_tree().call_group("enemy_group", "change_direction")

func destroy():
	queue_free()
