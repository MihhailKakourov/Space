extends CharacterBody2D

const SPEED = 30.0

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(Vector2.DOWN * delta * SPEED)
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("take_damage"):
			_destroy()
			collider.take_damage()
			
			
func _destroy():
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	_destroy()
