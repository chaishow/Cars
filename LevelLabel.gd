extends Label


func _ready():
	text = 'Уровень 1'
	






func _on_level_level_changed(level):
	text = 'Уровень '+str(level)
