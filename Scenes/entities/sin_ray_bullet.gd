extends Node2D
@export var movement_speed:float = 200
@export var wave_offset_value:float = 50

var player_global_position:Vector2
var direction_to_player:Vector2
var distance_travelled_on_line:float
var initital_position:Vector2
var perpandicular_direction

func _ready() -> void:
	#initital_position = global_position
	pass

func _process(delta: float) -> void:
	distance_travelled_on_line += movement_speed * delta
	var base_position = initital_position + (direction_to_player * distance_travelled_on_line)
	#global_position -= (direction_to_player*200) * delta
	perpandicular_direction = direction_to_player.orthogonal()
	
	var wave_offset = sin(deg_to_rad(distance_travelled_on_line))*wave_offset_value
	
	global_position = base_position + (perpandicular_direction * wave_offset)
	
	# clear the bullet if it's out of the viewport
	if global_position.x > 640 or global_position.y > 480 or global_position.x < 0 or global_position.y < 0:
		#print(global_position)
		queue_free() 
		
