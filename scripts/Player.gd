extends KinematicBody2D

export var speed = 250

export var jump_speed = -500
var gravity = 1200

var flying = false

var direction := Vector2.ZERO

var pushed_up = false

var attacking = false

var used_portal = false

var start_position = Vector2.ZERO

var have_sword = false

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = global_position
	start_position.y -= 200
	GlobalSignals.connect("use_portal", self, "_use_portal")
	GlobalSignals.connect("player_reset", self, "_player_reset")
	GlobalSignals.connect("collected_sword", self, "_collected_sword")

func _player_reset():
	global_position = start_position
	
func _collected_sword():
	have_sword = true

func _can_fly(state):
	flying = state

func _push_up():
	pushed_up = true


func _input(event):
	
	direction.x = 0
	
	if Input.is_action_pressed("left"):
		direction.x -= speed
		$AttackNode.scale.x = -1
		$PlayerAnim.flip_h = true
		if not attacking:
			$PlayerAnim.play("walk")
		
	elif Input.is_action_pressed("right"):
		direction.x += speed
		$AttackNode.scale.x = 1
		$PlayerAnim.flip_h = false
		if not attacking:
			$PlayerAnim.play("walk")
	
	else:
		if not attacking:	
			$PlayerAnim.play("idle")
				
			
		
	if Input.is_action_just_pressed("attack") and have_sword:
		attacking = true
		$PlayerAnim.set_frame(0)
		$PlayerAnim.play("attack")	
		$AttackNode/AttackArea/AttackCollision.disabled = false
			


func _process(delta):
		
	direction.y += gravity * delta
		
	var is_grounded = $RayCastFloor.is_colliding() or $RayCastFloor2.is_colliding()
	
			
	if Input.is_action_just_pressed("jump") and not flying:
		if is_grounded:
			direction.y = jump_speed
	
	
	if Input.is_action_pressed("down") and flying:
		direction.y = -jump_speed

	if Input.is_action_pressed("jump") and flying:
		direction.y = jump_speed
	

	direction = move_and_slide(direction,  Vector2.UP)
	


func _on_PlayerAnim_animation_finished():
	if $PlayerAnim.animation == "attack":
		attacking = false
		$AttackNode/AttackArea/AttackCollision.disabled = true

func _use_portal(new_position):
	direction = Vector2.ZERO
	
	visible = false
	
	call_deferred("_collision_off")
	var tween = create_tween()
	tween.tween_property(self, "global_position", new_position, 1.0)
	yield (tween, "finished")
	call_deferred("_collision_on")
	visible = true


func _collision_off():
	$AttackNode/AttackArea/AttackCollision.disabled=true
	$PlayerCollision.disabled = true

func _collision_on():
	$PlayerCollision.disabled = false
	

