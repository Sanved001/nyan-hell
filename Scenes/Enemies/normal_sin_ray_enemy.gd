extends Node2D

var sin_ray = preload("res://Scenes/moves/sin_ray.tscn") 

@onready var summon_cooldown_timer: Timer = $Summon_Cooldown_Timer


@export var summon_cooldown:float = 3
@export var start_position:Vector2 = Vector2.ZERO
@export var end_position:Vector2 = Vector2.ZERO
@export var position_lerp_speed:float = 1.0
@export var exit_time:float = 10.0

var start_end_flip:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_timer(exit_time)
	global_position = start_position
	summon_cooldown_timer.start(summon_cooldown)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not start_end_flip:
		global_position = global_position.lerp(end_position, position_lerp_speed*delta)
	else:
		global_position = global_position.lerp(start_position, position_lerp_speed*delta)
		if global_position.distance_to(start_position) < 10:
			queue_free()

func summon_move_sinray():
	var sin_ray_instance = sin_ray.instantiate()
	
	#get_parent().add_child(spinner_instance)
	add_child(sin_ray_instance)
	sin_ray_instance.summon()
	sin_ray_instance.global_position = global_position


#func disown_child(child:Node2D):
	#if not is_instance_valid(child):
		#return
	#get_parent().add_child(child)


#func _on_summon_cooldown_timeout() -> void:
	


func _on_summon_cooldown_timer_timeout() -> void:
	summon_move_sinray()
	summon_cooldown_timer.start(summon_cooldown)

func exit_timer(value:float):
	await get_tree().create_timer(value).timeout
	if is_instance_valid(self):
		
		start_end_flip = true


func summon(m_start_position:Vector2, m_end_position:Vector2, m_position_lerp_speed:float, m_exit_time:float):
	start_position = m_start_position
	end_position = m_end_position
	position_lerp_speed = m_position_lerp_speed
	exit_time = m_exit_time
