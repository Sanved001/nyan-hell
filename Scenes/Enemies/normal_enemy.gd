extends Node2D

var spinner = preload("res://Scenes/moves/spinner.tscn") 

@onready var sin_ray_timer: Timer = $SinRayTimer

@export var child_disown_time:float = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func summon_move_spinner(m_bullet_rotation_speed:float,  m_spinner_rotation_value:float, m_spinner_starting_rotation:float, m_bullet_spawn_cooldown:float):
	var spinner_instance = spinner.instantiate()
	spinner_instance.summon(m_bullet_rotation_speed,  m_spinner_rotation_value, m_bullet_spawn_cooldown, m_spinner_starting_rotation)
	
	#get_parent().add_child(spinner_instance)
	add_child(spinner_instance)
	spinner_instance.global_position = global_position


func disown_child(child:Node2D):
	if not is_instance_valid(child):
		return
	get_parent().add_child(child)
