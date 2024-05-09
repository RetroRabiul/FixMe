extends KinematicBody2D



func _on_ammo_area_body_entered(body):
	if body.is_in_group("player"):
		GlobalVariables.bullets += 5
		GlobalSignals.emit_signal("update_ammo")
		queue_free()
