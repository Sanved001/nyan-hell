extends Node2D

var spinner = preload("res://Scenes/moves/spinner.tscn") 




@export var start_position:Vector2 = Vector2.ZERO
@export var end_position:Vector2 = Vector2.ZERO
@export var position_lerp_speed:float = 1.0
@export var exit_time:float = 10.0

var start_end_flip:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	summon_move_spinner(60, 60, 60, 0.01)
	exit_timer(exit_time)
	global_position = start_position



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not start_end_flip:
		global_position = global_position.lerp(end_position, position_lerp_speed*delta)
	else:
		global_position = global_position.lerp(start_position, position_lerp_speed*delta)
		if global_position.distance_to(start_position) < 10:
			queue_free()



func summon_move_spinner(m_bullet_rotation_speed:float,  m_spinner_rotation_value:float, m_spinner_starting_rotation:float, m_bullet_spawn_cooldown:float):
	var spinner_instance = spinner.instantiate()
	spinner_instance.summon(m_bullet_rotation_speed,  m_spinner_rotation_value, m_bullet_spawn_cooldown, m_spinner_starting_rotation)
	
	#get_parent().add_child(spinner_instance)
	add_child(spinner_instance)
	spinner_instance.global_position = global_position



func summon(m_start_position:Vector2, m_end_position:Vector2, m_position_lerp_speed:float, m_exit_time:float):
	start_position = m_start_position
	end_position = m_end_position
	position_lerp_speed = m_position_lerp_speed
	exit_time = m_exit_time

func exit_timer(value:float):
	await get_tree().create_timer(value).timeout
	if is_instance_valid(self):
		
		start_end_flip = true
