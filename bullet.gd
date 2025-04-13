extends RigidBody2D  # Use RigidBody2D for physics handling

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		queue_free()
