extends CharacterBody3D

var start_position = Vector3(0, 0.15, 16)
var start_score = 0

@export var v_speed = -2
@export var h_speed = -1.5

@onready var skin_conatainer = $car_taxi2

var is_pressed
var mouse_velocity = 0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var score = 0
signal score_changed(score)
signal player_reseted()

var level = 1

var can_move = true

var skins = [preload("res://KayKit_City_Builder_Bits_1.0_FREE/Assets/gltf/car_taxi.gltf"), preload("res://KayKit_City_Builder_Bits_1.0_FREE/Assets/gltf/car_hatchback.gltf"), preload("res://KayKit_City_Builder_Bits_1.0_FREE/Assets/gltf/car_police.gltf"), preload("res://KayKit_City_Builder_Bits_1.0_FREE/Assets/gltf/car_stationwagon.gltf")]

func _ready():
	change_skin(skins[level-1])

func _input(event):
	if can_move:
		if event is InputEventMouseButton:
			is_pressed = event.pressed
		if event is InputEventMouseMotion and is_pressed:
			mouse_velocity = event.relative[0]
		else:
			mouse_velocity = 0
	

func _process(delta):
	
	if can_move:
		if not is_on_floor():
			velocity.y -= gravity * delta
		translate(Vector3(0,0,v_speed*delta))
		if mouse_velocity > 0:
			translate(Vector3(-h_speed*delta, 0, 0))
		elif mouse_velocity<0:
			translate(Vector3(h_speed*delta, 0, 0))

		move_and_slide()



func increase_score(score):
	if score + self.score > 0:
		set_score(self.score+score)
	else:
		set_score(0)

func set_score(score):
	self.score = score
	score_changed.emit(self.score)

func reset():
	global_position = start_position
	level = 1
	player_reseted.emit()
	change_skin(skins[level-1])
	set_score(start_score)
	
	
func change_skin(new_skin):
	for skin in skin_conatainer.get_children():
		skin.queue_free()
	skin_conatainer.add_child(new_skin.instantiate())
