extends CharacterBody2D
class_name BasicEnemy

@export var speed = 80
@export var stop_distance: float = 25.0  #на каком расстоянии остановиться
@onready var sprite = $AnimatedSprite2D
@onready var shape = $CollisionShape2D
var player: Node2D

#TODO: Пофиксить коллизию после смены напраления взгляда врага

func _ready() -> void:
	player = get_tree().root.get_node("game/Player")


func _physics_process(delta: float) -> void:
	move_to_player()
	

func move_to_player() -> void:
	if is_instance_valid(player):
		var distance = global_position.distance_to(player.global_position)
		
		if distance > stop_distance:
			var dir: Vector2 = (player.global_position - global_position).normalized()
			velocity = dir * speed
		else:
			velocity = Vector2.ZERO
			
		movment_animation()
		move_and_slide()
		
func movment_animation() -> void:
	if velocity.length() > 0.1:
		#Смотрит в сторону движения
		if abs(velocity.x) > 0.1:
			body.scale.x = sign(velocity.x) #-1 if velocity.x < 0 else 1
		sprite.animation = "movment"
		sprite.play()
	else:
		sprite.animation = "idle"
		sprite.play()

func get_direction_to_player() -> Vector2:
	if is_instance_valid(player):
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO
