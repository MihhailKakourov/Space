extends CanvasLayer

@onready var coins: Label = $Coins
@onready var coin_error_panel: Panel = $CoinErrorPanel
@onready var player = get_node("/root/game/Player")
@onready var enemies: Array = []

var shop_open = false

func _ready():
	Events.coin_changed.connect(_on_coin_changed)

func open_shop():
	if shop_open:
		return
	shop_open = true
	get_tree().paused = true
	$AnimStart.play("transIn")

func _on_close_button_pressed():
	if not shop_open:
		return
	$AnimStart.play("transOut")
	get_tree().paused = false
	shop_open = false

func _on_purchase_pressed():
	if Globals.coin >= 5 and Globals.hp != 100:
		Globals.change_hp(15)
		Globals.change_coin(-5)
	else:
		coin_error_panel.visible = true

func _on_coin_changed(new_coin: int):
	coins.text = "Coins: %d" % new_coin

func _on_close_error_button_pressed():
	coin_error_panel.visible = false
