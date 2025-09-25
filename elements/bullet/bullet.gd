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

		# Враг
		var enemy: Node = null
		if target.is_in_group("Enemies"):
			enemy = target
		elif target.get_parent() and target.get_parent().is_in_group("Enemies"):
			enemy = target.get_parent()

		if enemy:
			if enemy.has_method("death"):
				enemy.death()
			else:
				enemy.queue_free()
			queue_free()
			get_tree().call_group("game", "spawn_new_word") # ← новое слово только тут!
			return

		# Стена
		if target is StaticBody2D:
			queue_free()
			return

	global_position += motion


func _on_area_entered(area: Area2D) -> void:
	var enemy: Node = null
	if area.is_in_group("Enemies"):
		enemy = area
	elif area.get_parent() and area.get_parent().is_in_group("Enemies"):
		enemy = area.get_parent()

	if enemy:
		if enemy.has_method("death"):
			enemy.death()
		else:
			enemy.queue_free()
		queue_free()
		get_tree().call_group("game", "spawn_new_word")
