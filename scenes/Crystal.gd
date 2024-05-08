extends KinematicBody2D

onready var collectingSound = $CollectedSound

func _on_Detect_body_entered(body):
	if body.is_in_group("player"):
		collectingSound.play()
		GlobalSignals.emit_signal("crystal_collected")
		$CPUParticles2D.emitting = true
		yield(collectingSound, "finished")
		$CPUParticles2D.emitting = false
#		_self_delete()
		call_deferred("_self_delete")
		
#		queue_free()


func _self_delete():
	queue_free()
