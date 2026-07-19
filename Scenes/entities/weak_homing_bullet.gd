extends Node2D

@export var speed: float = 250.0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta


	# clear the bullet if it's out of the viewport
	if global_position.x > 640 or global_position.y > 480 or global_position.x < 0 or global_position.y < 0:
		#print(global_position)
		queue_free() 
