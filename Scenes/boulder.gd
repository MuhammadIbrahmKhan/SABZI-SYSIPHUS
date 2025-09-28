
extends RigidBody2D

	

func _on_body_entered(body: Node) -> void:
	if body.name == "player":
		body.Lives -=1
	if body.name == "StaticBody2D":
		queue_free()
		pass # Replace with function body.
