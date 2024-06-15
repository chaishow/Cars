extends WorldEnvironment

@export var sky_rotation_speed = 20.0

func _physics_process(delta):
	environment.sky_rotation.y += sky_rotation_speed * delta
