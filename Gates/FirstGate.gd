extends "res://Gates/gate.gd"


signal player_went_throught

func _ready():
	level_coef = $"..".level_coef
	super._ready()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_collision_area_body_entered(body):
	super._on_collision_area_body_entered(body)
	if body.name == 'Player' and enabled:
		player_went_throught.emit()
	
