extends Control

var money_amount = 1000
signal money_amount_changed(amount)

func add_money(amount):
	money_amount += amount
	money_amount_changed.emit(money_amount)
	
func spend_money(amount):
	if is_enough_money(amount):
		money_amount -= amount
		money_amount_changed.emit(money_amount)

func is_enough_money(amount):
	if amount <= money_amount:
		return true
	return false
