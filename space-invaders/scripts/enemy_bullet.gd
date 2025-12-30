extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area. name. begins_with("player_bullet"):
		area. queue_free()
		queue_free()
	if area. name == "player":
		Global. life -= 1
		queue_free()
