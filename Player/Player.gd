extends CharacterBody3D

var start_position = Vector3(0, 0.15, 16)
var start_score = 0
var start_level=1
var Estimate = preload("res://Player/estimate_label.tscn")

@export var v_speed = -2
@export var h_speed = -1.8
@export var speed_delta = 5
var curent_speed = 0

@onready var skin_conatainer = $GifContainer/AnimatedSprite3D

var mouse_is_pressed
var mouse_velocity = 0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var score = 0
signal score_changed(score)
signal player_reseted()

var level = 1

var can_move = true

var skins = [preload("res://catmodels/cat-couple (1).gif"),
			preload("res://catmodels/cat-kitty (1).gif"), 
			preload("res://catmodels/catkiss-cat.gif"), 
			preload("res://catmodels/dance (1).gif"),
			preload("res://catmodels/silly-cat-cat-meme-face (1).gif")
			]

func _ready():
	change_skin(skins[level-1])
	velocity.z = v_speed

func _input(event):
	if can_move:
		if event is InputEventMouseButton:
			mouse_is_pressed = event.pressed
		else:
			mouse_velocity = 0
		if event is InputEventMouseMotion and mouse_is_pressed:
				mouse_velocity = event.relative[0]

		
	

func _process(delta):
	if can_move:
		if not is_on_floor():
			velocity.y -= gravity * delta
		
		if abs(mouse_velocity) < 3:
			decrease_h_spead(delta)
		else:
			if abs(mouse_velocity) > 0:
				curent_speed = min(curent_speed+speed_delta, h_speed)
			if mouse_velocity > 0:
				velocity.x = -curent_speed
			elif mouse_velocity < 0:
				velocity.x = curent_speed
			
		
		move_and_slide()

func decrease_h_spead(delta):
	if abs(velocity.x) > 0.3:
		if velocity.x > 0:
			velocity.x -= speed_delta*delta
		else:
			velocity.x += speed_delta*delta
	else:
		velocity.x = 0

func increase_score(score):
	make_estimate(score)
	
	if score + self.score > 0:
		set_score(self.score+score)
	else:
		set_score(0)

func set_level(level):
	if level>=1:
		self.level=level
	else:
		self.level=1

func set_score(score):
	self.score = score
	score_changed.emit(self.score)

func set_start_score(score):
	self.start_score += score
	set_score(start_score)
	

func reset():
	global_position = start_position
	set_level(start_level)
	player_reseted.emit()
	set_score(start_score)
	change_skin(skins[level-1])

func change_skin(new_skin):
	skin_conatainer.set_sprite_frames(new_skin)
	skin_conatainer.play("gif")
	
func make_estimate(score):
	var new_estimate = Estimate.instantiate()
	if score > 0:
		$GPUParticles3D.process_material.set_color('00ffff')
		new_estimate.text = new_estimate.good_estimates[randi()%len(new_estimate.good_estimates)]
	elif score < 0:
		$GPUParticles3D.process_material.set_color('ff0000')
		new_estimate.text = new_estimate.bad_estimates[randi()%len(new_estimate.bad_estimates)]
	new_estimate.position = Vector3(0, 0.6, 0.25)
	add_child(new_estimate)
	$GPUParticles3D.emitting = true
	
