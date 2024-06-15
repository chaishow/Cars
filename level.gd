extends Node3D

var gates = [preload("res://Gates/moving_gate.tscn"), preload("res://Gates/couple_gate.tscn")]

var level = 1

signal player_finished(score)
signal level_changed(level)

@onready var player = $Player
@onready var gates_container = $GatesContainer
@onready var start_menu = $UI/StartMenu
@onready var restart_menu = $UI/RestartMenu
@onready var finish = $FinishContainer/FinishMesh


func _ready():
	generate_gates()
	player.can_move = false
		
		


# Ворота
func create_gate(gate, g_position, level):
	var new_gate = gate.instantiate()
	new_gate.global_position = g_position
	new_gate.level_coef = snapped(level**0.5, 0.01)
	gates_container.add_child(new_gate)

func generate_gates():
	var new_g_position = 14
	var min_space = 1.6
	var max_space = 4.2
	var last_coord = -12
	while new_g_position-max_space > last_coord:
		var spawn_position = Vector3(0, 0, new_g_position)
		create_gate(gates[randi()%len(gates)], spawn_position, level)
		var space = randf_range(min_space, max_space)
		new_g_position = max(new_g_position-space, last_coord)

func delete_gates():
	for gate in gates_container.get_children():
		gate.queue_free()


func _on_finish_body_entered(body):
	if body.name == "Player":
		player_finished.emit(body.score)
		player.can_move = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		restart_menu.show()


func restart_game():
	level += 1
	level_changed.emit(level)
	player.reset()
	delete_gates()
	generate_gates()
	restart_menu.hide()
	start_menu.show()
	finish.reset()
	

func start_new_game():
	player.can_move = true
	start_menu.hide()
	
