extends Label3D

var good_estimates = ['Молодец', 'Круто', 'Твоя мама будет жить вечно']
var bad_estimates = ['Лох', 'Пидор', 'Мать чекай']

var ok = false
func _ready():
	$Timer.start()

func _process(delta):
	if ok:
		make_tranparent(delta)

func make_tranparent(delta):
	if transparency < 1:
		transparency += 2*delta
	else:
		queue_free()


func _on_timer_timeout():
	ok = true
