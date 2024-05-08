extends KinematicBody2D

onready var collectingSound = $CollectedSound

func _on_Detect_body_entered(body):
	if body.is_in_group("player"):
		$Detect/CollisionShape2D.set_deferred("disabled", true)
		$Sprite.hide()
		
		collectingSound.play()
		GlobalSignals.emit_signal("crystal_collected")
		$CPUParticles2D.emitting = true
		yield(collectingSound, "finished")
		
		var tween = create_tween()
		tween.tween_property($CPUParticles2D, "modulate:a", 0.0, 1.0)
		yield(tween, "finished")
		call_deferred("_self_delete")


func _self_delete():
	queue_free()
