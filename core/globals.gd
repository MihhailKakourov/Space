extends Node

var hp:= 100
var coin:= 0

func change_hp(diff: int):
	hp += diff
	if hp > 100:
		hp = 100
	Events.hp_changed.emit(hp)
	

func change_coin(diff: int):
	coin += diff
	Events.coin_changed.emit(coin)
