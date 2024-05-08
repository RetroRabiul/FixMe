extends Area2D


func _on_Life_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("life_collected")
		queue_free()

