extends CharacterBody2D

const SPEED = 300.0
@onready var anim = $AnimatedSprite2D
var last_dir = "down"

func _physics_process(delta):
	_movment()
	
func _movment():
	var LR = Input.get_axis("ui_left", "ui_right")
	var UD = Input.get_axis("ui_up", "ui_down")
	velocity = Vector2(LR, UD) * SPEED
	
	if velocity.length() > 0:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				anim.play("walk_right")
				last_dir = "right"
			else:
				anim.play("walk_left")
				last_dir = "left"
		else:
			if velocity.y > 0:
				anim.play("walk_down")
				last_dir = "down"
			else:
				anim.play("walk_up")
				last_dir = "up"
	else:
		anim.play("idle_" + last_dir)
	
	move_and_slide()
	
func take_damage(damage):
	Globals.change_hp(damage)
	print("Damage taken: " + str(damage))
