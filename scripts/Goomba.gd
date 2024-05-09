extends KinematicBody2D

const GRAVITY = 900

export var walk_speed = 100

var direction = Vector2.ZERO

export var walk_time:float = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$WalkTimer.wait_time = walk_time
	$WalkTimer.start()
	


func _process(delta):
	
	direction.y += GRAVITY * delta
	
	if is_on_floor():
		direction.x = walk_speed
	
	direction = move_and_slide(direction,  Vector2.UP)
	

func _on_WalkTimer_timeout():
	walk_speed *= -1
	


func _on_KillArea_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("player_reset")
#		queue_free()
		


func _on_DieArea_area_entered(area):	
	if area.is_in_group("player_weapon"):
#		GlobalSignals.emit_signal("player_reset")
		queue_free()


func _on_DieArea_body_entered(body):
	if body.is_in_group("ammo"):
		body.queue_free()
		queue_free()
