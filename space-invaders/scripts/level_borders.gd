extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area. name == "enemy_1_" or area. name == "enemy_1_2":
		Global. enemys_direction *= -1
		print(Global. enemys_direction)
