extends Sprite


export(NodePath) var crystals_path
onready var all_crystals = get_node(crystals_path)


func _check_crystals():
	var crystal_count = all_crystals.get_child_count()
	if crystal_count == 0:
		_next_level()
	else:
		GlobalSignals.emit_signal("show_sign", "Collect all the crystals first")


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		_check_crystals()


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("hide_sign")


#	get_tree().change_scene("res://scenes/GameOver.tscn")
func _next_level():
	GlobalVariables.current_level += 1
	
	match GlobalVariables.current_level:
		2:
			get_tree().change_scene("res://scenes/Level2.tscn")
		3:
			get_tree().change_scene("res://scenes/GameOver.tscn")
		_:
			get_tree().change_scene("res://scenes/GameOver.tscn")
	
	
	
	
	
	
	
	
	
	
	
	
	
	
