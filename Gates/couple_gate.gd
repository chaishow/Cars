extends Node3D

var children

var level_coef = 1


func _on_first_gate_player_went_throught():
	for child in get_children():
		child.enabled = false
		
