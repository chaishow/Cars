extends Button

@onready var player = $"../../../Player"
@onready var bank = $"../../Bank"
@onready var score_bar=player.get_node('ScoreBar')
var upgrade
var upgrade_cost = 100

func _ready():
	upgrade = 0.25*score_bar.current_goal
	text = 'Прокачать котика 
		+' + str(upgrade) + '
		Стоимость ' + str(upgrade_cost)
	

func _on_button_up():
	if bank.is_enough_money(upgrade_cost):
		bank.spend_money(upgrade_cost)
		player.set_start_score(upgrade)
		if player.score + upgrade>= score_bar.current_goal:
			player.start_level+=1
		upgrade =0.25*score_bar.current_goal
		upgrade = snapped(upgrade, 0.01)
		upgrade_cost *= 1.75
		upgrade_cost = snapped(upgrade_cost, 0.01)
		
		text = 'Прокачать котика 
		+' + str(upgrade) + '
		Стоимость ' + str(upgrade_cost)
