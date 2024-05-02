extends Sprite

var total_crystal = 0

export(NodePath) var crystals_path
onready var all_crystals = get_node(crystals_path)

func _ready():
	GlobalSignals.connect("crystal_collected", self, "_crystal_collected")

func _crystal_collected(crystal_count):
	total_crystal = crystal_count


func _check_crystals():
	var crystal_count = all_crystals.get_child_count()
	if crystal_count == total_crystal:
		print ("YOU WIN")
		get_tree().change_scene("res://scenes/GameOver.tscn")
	else:
		GlobalSignals.emit_signal("show_sign", "Collect all the crystals first")


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		_check_crystals()


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("hide_sign")
