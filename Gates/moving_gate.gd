extends "res://Gates/gate.gd"

var speed = 1.3
var direction = 1

var velocity = 0
var speed_delta = 0.6


func _process(delta):
	position.x += min(velocity+speed_delta, speed)*delta*direction
	velocity += speed_delta*delta

func _on_collision_area_body_entered(body):
	super._on_collision_area_body_entered(body)
	if 'Border' in body.name:
		direction = -direction
		velocity = 0
	
	
