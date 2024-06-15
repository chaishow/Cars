extends AnimationPlayer

@onready var player = $".."



func _on_animation_finished(anim_name):
	if anim_name == 'ScaleDown':
		player.change_skin(player.skins[player.level - 1])
		play('ScaleUp')


func _on_score_bar_goal_changed(goal):
	play("ScaleDown")
