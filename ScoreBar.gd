extends TextureProgressBar

@onready var player = $".."
var current_goal 
var previous 
signal goal_changed(goal)

func _ready():
	current_goal = calculate_new_goal(player.level)
	max_value = current_goal
	value = player.score
	previous = 0
	



func _on_player_score_changed(score):
	value = score
	if value >= current_goal:
		player.set_level(player.level+1)
		previous=current_goal
		current_goal=calculate_new_goal(player.level)
		max_value = current_goal
		goal_changed.emit(current_goal)
	elif value<previous:
		player.set_level(player.level-1)
		previous=calculate_new_goal(player.level-1)
		current_goal=calculate_new_goal(player.level)
		max_value=current_goal
		goal_changed.emit(current_goal)
	$ScoreLabel.text = str(score)
		

func calculate_new_goal(player_level):
	return 200*player_level+(1+player_level)**(player_level-1) - (player_level-4)*player_level**(player_level-1)

func _on_player_player_reseted():
	current_goal=calculate_new_goal(player.level)
	previous = 0
	max_value=current_goal
		
