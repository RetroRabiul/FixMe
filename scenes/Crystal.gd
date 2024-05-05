extends KinematicBody2D


func _on_Detect_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("crystal_collected")
		queue_free()
