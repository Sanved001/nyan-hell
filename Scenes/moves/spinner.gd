extends Node2D

var bullet = preload("res://Scenes/entities/spinner_bullet.tscn")

@onready var bullet_spawn_timer: Timer = $Bullet_Spawn_Timer







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
	get_parent().add_child(bullet_a)
	bullet_a.global_position = self.global_position
	bullet_spawn_timer.start(bullet_spawn_cooldown)
