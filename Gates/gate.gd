extends Node3D

var level_coef = 1
var coef  
var score
var enabled = true

@onready var mesh = $GateMesh


func _ready():
	coef = [-1, 1, 1][randi()%2]
	if coef > 0:
		mesh.set_material_override(load("res://materials/positive_gates.tres"))
	else:
		mesh.set_material_override(load("res://materials/negative_gates.tres"))
	score = (randi()%100+1)*coef*level_coef
	$Label3D.text = str(score)




func _on_collision_area_body_entered(body):
	if body.name == 'Player' and enabled:
		body.increase_score(score)
		queue_free()

		
		
