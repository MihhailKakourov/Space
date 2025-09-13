extends CharacterBody2D

@onready var reycast_left := $RayCast2DLeft
@onready var reycast_right := $RayCast2DRight

const BULLET_SECENE = preload("res://elements/EnemyBullet/enemy_bullet.tscn")

func _physics_process(delta: float) -> void:
	if reycast_left.is_colliding() or reycast_right.is_colliding():
		get_tree().call_group("enemy_group", "change_direction")

func destroy():
	Globals.change_points(1)
	queue_free()


func shot():
	var bullet = BULLET_SECENE.instantiate()
	bullet.global_position = global_position + Vector2(0, 10.0)
	get_parent().add_child(bullet)
