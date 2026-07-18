extends Node2D


var my_speed = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

var launch_var = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if launch_var:
		position.y += my_speed*delta
		if position.y > 500:
			queue_free()


func launch():
	await get_tree().create_timer(0.1).timeout
	launch_var = true
