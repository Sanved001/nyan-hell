extends Node2D

var bullet = preload("res://Scenes/entities/spinner_bullet.tscn")

@onready var bullet_spawn_timer: Timer = $Bullet_Spawn_Timer






var rotation_speed:float = 1
var bullet_spawn_cooldown:float = 0.2
var my_rotation_value:float = 60
var is_bullet_spawn_cooldown:bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_bullet_spawn_timer_timeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	rotate(deg_to_rad(my_rotation_value)*delta)






func _on_bullet_spawn_timer_timeout() -> void:
	var bullet_a = bullet.instantiate()
	bullet_a.rotation = rotation
	bullet_a.rotation_speed = rotation_speed
	
	GameManager.get_Current_Level().add_child(bullet_a)
	#get_tree().current_scene.add_child(bullet_a)

	bullet_a.global_position = self.global_position
	bullet_spawn_timer.start(bullet_spawn_cooldown)

func summon(m_rotation_speed:float, spinner_rotation_value:float, m_bullet_spawn_cooldown:float, m_spinner_starting_rotation:float):
	rotation_speed = m_rotation_speed
	bullet_spawn_cooldown = m_bullet_spawn_cooldown
	my_rotation_value = spinner_rotation_value
	rotation = m_spinner_starting_rotation
		
