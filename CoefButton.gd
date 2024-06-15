extends Button

@onready var restart_menu = $"../../RestartMenu"
@onready var bank = $"../../Bank"
var upgrade_cost = 100
var upgrade = 0.015

func _ready():
	text = 'Продать дороже 
		+' + str((restart_menu.sale_coef-1+upgrade)*100) + '%
		Стоимость ' + str(upgrade_cost)




func _on_button_up():
	if bank.is_enough_money(upgrade_cost):
		bank.spend_money(upgrade_cost)
		restart_menu.sale_coef += snapped(upgrade, 0.001)
		restart_menu.sale_coef = snapped(restart_menu.sale_coef, 0.001)
		upgrade_cost *= 1.75
		upgrade_cost = snapped(upgrade_cost, 0.01)
		text = 'Продать дороже 
			+' + str(snapped((restart_menu.sale_coef-1+upgrade)*100 , 0.001)) + '%
			Стоимость ' + str(upgrade_cost)
	
