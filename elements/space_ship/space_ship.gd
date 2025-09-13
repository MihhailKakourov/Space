extends CharacterBody2D

const SPEED = 300
const ROCKET_SCENE = preload("res://elements/rocket/rocket.tscn")

#https://www.youtube.com/watch?v=8Jgm0qrl9tE (28:10)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		shot()
	
	var direction = Input.get_axis("ui_left", "ui_right")
	#global_position.x = direction * SPEED * delta
	velocity.x = direction * SPEED
	
	move_and_slide()
	
func shot():
	var rocket = ROCKET_SCENE.instantiate()
	rocket.global_position = global_position + Vector2(0, -25)
	#print("Ship position: " + str(global_position))
	#print("Rocket position: " + str(rocket.global_position))
	get_parent().add_child(rocket) # <- вместо add_child(rocket)
	
	
func take_damage():
	Globals.lives_changed(-1)
