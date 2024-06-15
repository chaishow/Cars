extends Control

var current_score = 0
var sale_coef = 1

@onready var bank = $"../Bank"
@onready var level = $"../.."

func _ready():
	hide()

func _on_level_player_finished(score):
	current_score = score





func _on_sell_button_button_up():
	bank.add_money(current_score*sale_coef)
	level.restart_game()

