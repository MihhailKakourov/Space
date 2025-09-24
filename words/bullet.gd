extends Area2D

@export var speed := 400.0
var direction := Vector2.ZERO

func _ready():
	$AnimatedSprite2D.play("default")
	rotation = direction.angle()
	connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta):
	position += direction * speed * delta

func _on_area_entered(area: Area2D):
	if area.is_in_group("Enemies"):
		var enemy = area.get_parent()    # hit-box → родитель = SkeletonEnemy2
		enemy.queue_free()               # убиваем врага целиком
		queue_free()                     # удаляем пулю
		get_tree().call_group("game", "spawn_new_word") # новое слово
