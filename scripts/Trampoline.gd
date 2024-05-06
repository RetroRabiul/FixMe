extends Node2D

var stop_jump = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Trampoline_body_entered(body):
	if body.is_in_group("player") and not stop_jump:
		GlobalSignals.emit_signal("trampoline")


func _on_StopBounce_body_entered(body):
	if body.is_in_group("player"):
		call_deferred("_stop_jump")
		stop_jump = true
		

func _stop_jump():
	$Trampoline/Bounce.disabled = true


func _on_StopBounce_body_exited(body):
	if body.is_in_group("player"):
		call_deferred("_can_jump")
		stop_jump = false

func _can_jump():
	$Trampoline/Bounce.disabled = false
