extends Node

var hp:= 100

func change_hp(diff: int):
	hp += diff
	Events.hp_changed.emit(hp)
