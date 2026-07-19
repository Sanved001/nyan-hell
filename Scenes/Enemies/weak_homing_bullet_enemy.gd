extends CharacterBody2D

@onready var spawn_bullet_timer: Timer = $SpawnBulletTimer

var weak_homing_bullet = preload("res://Scenes/entities/weak_homing_bullet.tscn")

# 0 = top
# 1 = top_left
# 2 = top_right
# 3 = left
# 4 = right
@export var start_on:int = 0 
# 0 = bottom
# 1 = left
# 2 = right
@export var end_on:int = 0

@export var offset_x:float = 0.0
@export var offset_y:float = 0.0

@export var piviot_point:float = 54

@export var speed_increase_value:float = 1.0
@export var max_speed = Vector2(50,50)


var speed:Vector2 = Vector2(0,0)


func _ready() -> void:
	_on_spawn_bullet_timer_timeout()
	
	position += Vector2(offset_x, offset_y)
	if start_on != 0:
		if start_on != 1:
			if start_on != 2:
				speed.x = 20

var Fire_once_at_y_216:bool = true
func _process(delta: float) -> void:
	
	if position.y < piviot_point:
		if start_on == 0:
			position += Vector2(0,speed.y*delta)
			speed.y += speed_increase_value*delta
			speed.y = clampf(speed.y, speed.y, max_speed.y)
		if start_on == 1:
			position += Vector2(0,speed.y*delta)
			speed.y += speed_increase_value*delta
			speed.y = clampf(speed.y, speed.y, max_speed.y)
		if start_on == 2: 
			position += Vector2(0,speed.y*delta)
			speed.y += speed_increase_value*delta
			speed.y = clampf(speed.y, speed.y, max_speed.y)
		if start_on == 3: 
			position += Vector2(speed.x*delta, speed.y*delta)
			speed.x -= speed_increase_value*delta
			speed.x = clampf(speed.x, 1, max_speed.x)
			speed.y += speed_increase_value*delta
			speed.y = clampf(speed.y, 1, max_speed.y)
		if start_on == 4: 
			position += Vector2(-speed.x*delta, speed.y*delta)
			speed.x -= speed_increase_value*delta
			speed.x = clampf(speed.x, 1, max_speed.x)
			speed.y += speed_increase_value*delta
			speed.y = clampf(speed.y, 1, max_speed.y)
	else:
		if Fire_once_at_y_216:
			#speed.x = 0
			Fire_once_at_y_216 = false
		if end_on == 0:
			position += Vector2(0,speed.y*delta)
		elif end_on == 1:
			position += Vector2(speed.x*delta,speed.y*delta)
			speed.x -= speed_increase_value*delta
			#speed.y -= speed_increase_value * delta
			#speed.y = clampf(speed.y, 1, max_speed.y)
		elif end_on == 2:
			position += Vector2(speed.x*delta,speed.y*delta)
			speed.x += speed_increase_value*delta
			#speed.y -= speed_increase_value * delta
			#speed.y = clampf(speed.y, 1, max_speed.y)
	
	
	if global_position.x > 2000 or global_position.y > 2000 or global_position.x < -2000 or global_position.y < -2000:
		queue_free()


# 384, 432
func summon(m_start_on:String, m_end_on:String, m_offset_x:float, m_offset_y:float, m_speed_increase_value:float = 1, m_max_speed:Vector2 = Vector2(50,50), m_piviot_point:float = 54):
	if m_start_on == "top":
		position = Vector2(192, -50)
		start_on = 0
	elif m_start_on == "top_left":
		position = Vector2(192-96, -50)
		start_on = 1
	elif m_start_on == "top_right":
		position = Vector2(192+96, -50)
		start_on = 2
	elif m_start_on == "left":
		position = Vector2(-50, 0)
		start_on = 3
	elif m_start_on == "right":
		position = Vector2(384+50, 0)
		start_on = 4

	if m_end_on == "bottom": end_on = 0
	elif m_end_on == "left": end_on = 1
	elif m_end_on == "right": end_on = 2
	
	offset_x = m_offset_x
	offset_y = m_offset_y 
	speed_increase_value = m_speed_increase_value
	max_speed = m_max_speed
	piviot_point = m_piviot_point


func _on_spawn_bullet_timer_timeout() -> void:
	var homing_bullet = weak_homing_bullet.instantiate()
	
	GameManager.get_Current_Level().add_child(homing_bullet)
	homing_bullet.global_position = global_position
	spawn_bullet_timer.start()
