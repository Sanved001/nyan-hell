extends Node2D

var bullet = preload("res://Scenes/entities/sin_ray_bullet.tscn")

@export var line_length:float = 500
@export var bullet_spawn_cooldown:float = 0.001


@onready var bullet_spawn_timer: Timer = $Bullet_Spawn_Timer
@onready var sin_ray_timer: Timer = $SinRayTimer







var sin_ray_time:float = 3.5
var is_bullet_spawn_cooldown:bool = false
var player_global_pos:Vector2 = Vector2.ZERO
var line_to_player:Vector2
var direction_to_player:Vector2
var plane_to_player:Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	player_global_pos = PlayerManager.get_player_global_position()
	line_to_player = player_global_pos - global_position
	direction_to_player = line_to_player.normalized()
	
	plane_to_player = direction_to_player * line_length

	



var m_tick:bool = false
func _on_bullet_spawn_timer_timeout() -> void:
	if not bullet_spawn_timer.is_stopped():
		return
	if m_tick:
		m_tick = false
	else: m_tick = true
	
	var bullet_a = bullet.instantiate()
	bullet_a.rotation = rotation
	bullet_a.player_global_position = player_global_pos
	bullet_a.direction_to_player = direction_to_player
	bullet_a.initital_position = global_position
	
	if m_tick: bullet_a.wave_offset_value = 50
	else: bullet_a.wave_offset_value = -50
	
	GameManager.get_Current_Level().add_child(bullet_a)
	bullet_a.global_position = self.global_position
	bullet_spawn_timer.start(bullet_spawn_cooldown)

func sin_ray_timer_start():
	sin_ray_timer.start(sin_ray_time)


func _on_sin_ray_timer_timeout() -> void:
	queue_free()

# func summon_move_sinray(m_bullet_rotation_speed:float,
	#m_spinner_rotation_value:float, 
	#m_spinner_starting_rotation:float, 
	#m_bullet_spawn_cooldown:float):
func summon(lasting_time:float = 1 , bullet_cooldown:float = 0.001):
	sin_ray_time = lasting_time
	bullet_spawn_cooldown = bullet_cooldown
	sin_ray_timer.start()
	_on_bullet_spawn_timer_timeout()
