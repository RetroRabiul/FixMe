extends Node2D


export(NodePath) var linked_portal_path
onready var linked_portal = get_node(linked_portal_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_PortalArea_body_entered(body):
	if body.is_in_group("player"):
#		not body.used_portal
		if body.used_portal == false:
			body.used_portal = true
			GlobalSignals.emit_signal("use_portal", linked_portal.global_position)
		else:
			body.used_portal = false	
		
		
#		if not body.used_portal:
#			body.used_portal = true
#			body.global_position = linked_portal.global_position
#			GlobalSignals.emit_signal("use_portal", linked_portal.global_position)
#			
#		else:
#			body.used_portal = false
