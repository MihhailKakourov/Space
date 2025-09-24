extends CharacterBody2D
class_name BasicEnemy

@export var speed = 80
@export var stop_distance: float = 26.0  #на каком расстоянии остановиться
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackA: AnimationPlayer = $AnimationPlayer
@onready var shape_left: CollisionShape2D = $CollisionShape2DLeft
@onready var shape_right: CollisionShape2D = $CollisionShape2DRight
var player: Node2D
var attacking := false


#TODO: Пофиксить коллизию после смены направления взгляда врага

func _ready() -> void:
	player = get_tree().root.get_node("game/Player")
	attackA.animation_finished.connect(_on_attack_finished)
	#print(player)


func _physics_process(delta: float) -> void:
	move_to_player()
	

func move_to_player() -> void:
	if is_instance_valid(player):
		var distance = global_position.distance_to(player.global_position)
		print("Distance: " + str(distance) + " | Stop Distance: " + str(stop_distance))
		
		if distance > stop_distance:
			var dir: Vector2 = get_direction_to_player()
			if dir:
				velocity = dir * speed
			else:
				velocity = Vector2.ZERO
		else:
			velocity = Vector2.ZERO
			if not attacking:
				attack()
			
		movement_animation()
		move_and_slide()
		
func movement_animation() -> void:
	if velocity.length() > 0.1:
		if abs(velocity.x) > 0.1:
			# flip sprite и переключаем коллизию
			sprite.flip_h = velocity.x < 0
			if velocity.x < 0:
				shape_left.disabled = true
				shape_right.disabled = false
				#sprite.position = Vector2(13, sprite.position.y)
			else:
				shape_left.disabled = false
				shape_right.disabled = true
		sprite.animation = "movement"
		sprite.play()
	else:
		sprite.animation = "idle"
		sprite.play()
		
func attack() -> void:
	attackA.play("attack")
	
func get_direction_to_player() -> Vector2:
	if is_instance_valid(player):
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO
	
func _on_attack_finished(name: String) -> void:
	if name == "attack":
		attacking = false
