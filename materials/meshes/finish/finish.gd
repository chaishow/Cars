extends Node3D

@onready var anim_controller = $AnimationPlayer


func _on_prepare_finish_area_body_entered(body):
	if body.name == 'Player':
		anim_controller.play('ComeIn')

func reset():
	position = Vector3(0, -5, -3)
