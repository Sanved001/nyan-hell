extends Node2D

var sin_ray = preload("res://Scenes/moves/sin_ray.tscn")
var spinner = preload("res://Scenes/moves/spinner.tscn") 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func summon_move_spinner(m_bullet_rotation_speed:float,  m_spinner_rotation_value:float, m_spinner_starting_rotation:float, m_bullet_spawn_cooldown:float):
	var spinner_instance = spinner.instantiate()
	spinner_instance.summon(m_bullet_rotation_speed,  m_spinner_rotation_value, m_bullet_spawn_cooldown, m_spinner_starting_rotation)
	
	#get_parent().add_child(spinner_instance)
	add_child(spinner_instance)
	spinner_instance.global_position = global_position
