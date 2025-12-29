extends Area2D

var health = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += Global.speed * delta * Global.enemys_direction * Global.enemy_speed_mult
	if Global. enemy_bottom:
		call_deferred("down")
	for bullet in $bullets.get_children():
		bullet. position. y -= Global.speed * delta * Global.bullet_speed_mult /6
func down():
	position. y += 40
	Global. enemy_bottom = false

func _on_area_entered(area: Area2D) -> void:
	if area.name in ["player_bullet"] or (area.name.begins_with("player_bullet")):
		health -= Global. damage
		if health > 0:
			$AnimatedSprite2D.animation = "level%s" %health
		else:
			queue_free()
		area. queue_free()
	if area. name == "level_borders":
		Global. enemys_direction *= -1
		Global. enemy_bottom = true

func _on_timer_timeout() -> void:
	var bullet = load("res://scenes/enemy_bullet.tscn"). instantiate()
	$bullets.add_child(bullet)
