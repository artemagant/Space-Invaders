extends Node2D

@onready var enemys = get_node_or_null("enemys")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global. next_level = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if enemys. get_children() == []:
		Global. next_level = true 
