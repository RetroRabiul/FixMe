extends KinematicBody2D

var velocity = Vector2.ZERO

var speed = 800

func _ready():
	pass 

func shoot(pos, dir):
	global_position = pos
	rotation = dir.angle()
	velocity = dir * speed

func _process(delta):
	var collided = move_and_collide(velocity * delta)
	if collided and collided.get_collider():
#		var hit_object = collided.get_collider()
#		if hit_object.has_method("was_hit"):
#			hit_object.was_hit()
#		print(hit_object.name)
		queue_free()

