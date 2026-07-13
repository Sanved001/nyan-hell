extends Node2D

var bullet = preload("res://Scenes/entities/sin_ray_bullet.tscn")
@onready var bullet_spawn_timer: Timer = $Bullet_Spawn_Timer


var is_bullet_spawn_cooldown:bool = false
var bullet_spawn_cooldown:float = 0.2
var global_player_pos:Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_player_pos = PlayerManager.get_player_global_position()
	_on_bullet_spawn_timer_timeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var m_tick:bool = false
func _on_bullet_spawn_timer_timeout() -> void:
	if m_tick:
		m_tick = false
	else: m_tick = true
	
	var bullet_a = bullet.instantiate()
	bullet_a.rotation = rotation
	bullet_a.player_global_position = global_player_pos
	get_parent().add_child(bullet_a)
	bullet_a.initial_position = self.global_position
	bullet_a.global_position = self.global_position
	bullet_spawn_timer.start(bullet_spawn_cooldown)
