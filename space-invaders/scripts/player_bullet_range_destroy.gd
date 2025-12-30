extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.name in ["player_bullet"] or (area.name.begins_with("player_bullet")):
		area. queue_free()
	if area.name in ["enemy_bullet"] or (area.name.begins_with("enemy_bullet")):
		area. queue_free()
	if area. name. begins_with("enemy_"):
		Global. life  = 0
