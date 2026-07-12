extends Node2D

var rotation_speed:float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# 640x480
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += deg_to_rad(rotation_speed*delta)
	position += Vector2(1,0).rotated(rotation)
	
	if global_position.x > 640 or global_position.y > 480 or global_position.x < 0 or global_position.y < 0:
		queue_free()
