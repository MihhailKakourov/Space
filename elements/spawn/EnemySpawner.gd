extends Node

@export var spawn_interval: float = 8.0
@export var min_spawn_interval: float = 2.0
@export var decrease_step: float = 0.5
@export var decrease_period: float = 60.0
var skeleton_scene = preload("res://elements/enemies/enemy_skeleton1/enemy_skeleton_1.tscn") # путь к врагу
var skeleton2_scene = preload("res://elements/enemies/skeleton_enemy_2/skeleton_enemy_2.tscn") # если разные враги
@export var map_path: NodePath = ^"../main_map/EnemySpawns"

var _time_passed: float = 0.0
var _timer: Timer

func _ready():
	_timer = Timer.new()
	_timer.wait_time = spawn_interval
	_timer.one_shot = false
	_timer.autostart = true
	add_child(_timer)
	_timer.timeout.connect(_on_spawn_timeout)

func _process(delta: float) -> void:
	_time_passed += delta
	if _time_passed >= decrease_period:
		_time_passed = 0.0
		spawn_interval = max(min_spawn_interval, spawn_interval - decrease_step)
		_timer.wait_time = spawn_interval

func _on_spawn_timeout():
	var count = 1 + randi() % 2
	spawn_enemies(count, true)

func spawn_enemies(count: int = 1, different_rooms: bool = false):
	var spawns_node: Node = get_node(map_path)

	var spawn_points: Array = spawns_node.get_children()
	if spawn_points.is_empty():
		return

	if different_rooms:
		spawn_points.shuffle()
		for i in range(min(count, spawn_points.size())):
			_spawn_one(spawn_points[i].global_position)
	else:
		for i in range(count):
			var spawn_point = spawn_points[randi() % spawn_points.size()]
			_spawn_one(spawn_point.global_position)

func _spawn_one(pos: Vector2):
	var enemy_scenes = [skeleton_scene, skeleton2_scene]
	var scene: PackedScene = enemy_scenes[randi() % enemy_scenes.size()]
	var enemy = scene.instantiate()
	enemy.global_position = pos
	get_tree().current_scene.add_child(enemy)
