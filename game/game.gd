extends Node2D

const GAME_OVER_SCENE = preload("res://ui/gameOver/game_over.tscn")

func _ready() -> void:
	Events.lives_changed.connect(func(lives:int): check_game_over())
	Events.enemy_died.connect(check_game_over)
	
func check_game_over():
	var enemies = get_tree().get_nodes_in_group("enemy")
	#print("Enemies: " + str(enemies.size()))
	#print("Lives: " + str(Globals.lives))
	if Globals.lives <= 0 or enemies.size() <= 1:
		Globals.lives = 3
		Globals.points = 0
		add_child(GAME_OVER_SCENE.instantiate())
