extends CharacterBody2D
class_name BasicEnemy

@export var speed = 80
@export var damage = -10
@export var stop_distance: float = 26.0  #на каком расстоянии остановиться
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackA: AnimationPlayer = $AttackAnimationPlayer
@onready var shape_left: CollisionShape2D = $CollisionShape2DLeft
@onready var shape_right: CollisionShape2D = $CollisionShape2DRight
@onready var hitbox: Area2D = $HitBox
var player: Node2D
var attacking := false


#TODO: Пофиксить коллизию после смены направления взгляда врага

func _ready() -> void:
	player = get_tree().root.get_node("game/Player")
	attackA.animation_finished.connect(_on_attack_finished)
	hitbox.body_entered.connect(_on_hitbox_body_entered) # если HitBox видит body
	#print(attackA)
	#print(attackA.get_animation_list())
	#print(player)


func _physics_process(delta: float) -> void:
	move_to_player()
	

func move_to_player() -> void:
	if attacking or sprite.animation == "death":
		return
		
	if is_instance_valid(player):
		var distance = global_position.distance_to(player.global_position)
		#print("Distance: " + str(distance) + " | Stop Distance: " + str(stop_distance))
		
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
	attacking = true
	attackA.play("attack")
	
func death() -> void:
	velocity = Vector2.ZERO
	sprite.play("death")

	shape_left.disabled = true
	shape_right.disabled = true

	if is_instance_valid(hitbox):
		hitbox.monitoring = false
		hitbox.monitorable = false

	remove_from_group("Enemies")

	await sprite.animation_finished
	set_physics_process(false)

	await get_tree().create_timer(10.0).timeout
	if is_instance_valid(self):
		queue_free()


	
func get_direction_to_player() -> Vector2:
	if is_instance_valid(player):
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO
	
func _on_attack_finished(name: String) -> void:
	if name == "attack":
		attacking = false
		
func _on_hitbox_body_entered(body: Node) -> void:
	#проверка группы
	if body.is_in_group("Player"):
		# роверка, есть ли метод take_damage
		if body.has_method("take_damage"):
			body.take_damage(damage)
