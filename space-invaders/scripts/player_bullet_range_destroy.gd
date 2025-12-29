extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area. name == "player_bullet" or area. name == "player_bullet2" or area. name == "player_bullet3" or area. name == "player_bullet4" or area. name == "player_bullet5":
		area. queue_free()
