extends Area2D

@export var speed: float = 600.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	rotation = direction.angle()
	connect("area_entered", Callable(self, "_on_area_entered"))

func _physics_process(delta: float) -> void:
	var motion: Vector2 = direction * speed * delta

	var space_state: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(global_position, global_position + motion)
	query.exclude = [self]
	query.collide_with_areas = true
	query.collide_with_bodies = true

	var hit: Dictionary = space_state.intersect_ray(query)

	if hit.size() > 0:
		var target: Node = hit["collider"]

		if target == null:
			return

		if target.is_in_group("Enemies"):
			target.queue_free()
			queue_free()
			get_tree().call_group("game", "spawn_new_word")
			return
		elif target.get_parent() and target.get_parent().is_in_group("Enemies"):
			target.get_parent().queue_free()
			queue_free()
			get_tree().call_group("game", "spawn_new_word")
			return

		# если попали в стену
		if target is StaticBody2D:
			queue_free()
			return

	global_position += motion

func _on_area_entered(area: Area2D) -> void:
	var target: Node = area
	if target.is_in_group("Enemies"):
		target.queue_free()
		queue_free()
		get_tree().call_group("game", "spawn_new_word")
	elif target.get_parent() and target.get_parent().is_in_group("Enemies"):
		target.get_parent().queue_free()
		queue_free()
		get_tree().call_group("game", "spawn_new_word")
