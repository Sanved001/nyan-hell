extends Node2D

var Bullet_Speed:float = 10.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= Bullet_Speed
	
	
	if global_position.x > 640 or global_position.y > 480 or global_position.x < 0 or global_position.y < 0:
		queue_free()
