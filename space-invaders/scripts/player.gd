extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global. left and position. x > 35:
		position. x -= Global. speed * delta
		$AnimatedSprite2D.animation = "left"
		Global. pos_player = Vector2(position. x, position. y)
		$AnimatedSprite2D.position.x = 2
	if Global. right and position. x < 1117:
		position. x += Global. speed * delta
		Global. pos_player = Vector2(position. x, position. y)
		$AnimatedSprite2D.animation = "right"
		$AnimatedSprite2D.position.x = -2
	if Global. left == Global. right:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.position.x = 0
	if position. x < 35 or position. x > 1117:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.position.x = 0
