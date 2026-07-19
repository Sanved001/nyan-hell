extends Node2D
@onready var stage_1_bg: Node2D = $Stage1_Bg

var stage_music = preload("res://Assets/DO_NOT_PUSH/assets/BGM/banjo_something.mp3")
var boss_music = preload("res://Assets/DO_NOT_PUSH/assets/BGM/f_d.mp3")
var flying_bullet = preload("res://Scenes/entities/flying_bullet.tscn")
var weak_homing_bullet_enemy = preload("res://Scenes/Enemies/weak_homing_bullet_enemy.tscn")
var sin_ray_enemy = preload("res://Scenes/Enemies/normal_sin_ray_enemy.tscn")
var spinner_enemy = preload("res://Scenes/Enemies/normal_spinner_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Bgm.playing:
		if Bgm.stream != stage_music:
			Bgm.stream = stage_music
		Bgm.play()
	if Bgm.volume_db < 0.0:
		Bgm.volume_db = 0.0
	GameManager.current_level = self 


var stage_music_toggle = false
var at0:bool = false
var at1700:bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	SignalBus.update_stage_y.emit(stage_1_bg.position.y)
	if stage_1_bg.position.y <= 4790:
		stage_1_bg.position.y += 50*delta

	if not at0:
		if 0.0 < stage_1_bg.position.y:
			at0 = true
			#summon_Flying_Bullet(0.2, 500, -30)
			#summon_Flying_Bullet(0.2, 500)
			#summon_Flying_Bullet(0.2, 500, 30)
			
			var x_offset_list = [0.0, 25.0, 50.0]
			for m_XOL in x_offset_list: 
				# TOP LEFT TO BOTTOM RIGHT
				for i in range(8):
					summon_weak_homing_bullet_enemy(i*3, "top_left", "right", m_XOL, 0.0, 10, Vector2(100,100), 0, 10.0)
				# TOP RIGHT TO BOTTOM LEFT
				for i in range(8):
					summon_weak_homing_bullet_enemy(i*3, "top_right", "left", m_XOL, 0.0, 10, Vector2(100,100), 0, 10.0)

	if not at1700:
		if 1700.0 < stage_1_bg.position.y:
			at1700 = true
			#summon_Flying_Bullet(0.2, 500, -30)
			#summon_Flying_Bullet(0.2, 500)
			#summon_Flying_Bullet(0.2, 500, 30)

			summon_sin_ray_enemy(Vector2(196, -200),Vector2(196, 50), 1, 20)
			#summon_normal_spinner_enemy(Vector2(50, -200),Vector2(50, 200), 1, 10, 10, 60, 0, 0.02)
			#summon_normal_spinner_enemy(Vector2(292, -200),Vector2(292, 200), 1, -10, 10, 60, 0, 0.02)
			
			summon_normal_spinner_enemy(Vector2(20, -20), Vector2(120, 60), 1.5, 20, 10, 60, 200, 0.1) # Top Left
			summon_normal_spinner_enemy(Vector2(320, -20), Vector2(340, 60), 1.5, 20, -10, -60, 160, 0.1) # Top Right


	if 4790.0 < stage_1_bg.position.y:
		if stage_music_toggle == false:
			stage_music_toggle = true
			Bgm.stop()
			#Bgm.stream = boss_music
			#Bgm.play()
		
		

func summon_Flying_Bullet(wait_time:float, flying_bullet_speed:float, offset_x:float = 0.0):
	await get_tree().create_timer(wait_time).timeout
	if not is_instance_valid(self): return
	
	var m_flying_bullet = flying_bullet.instantiate()
	
	m_flying_bullet.my_speed = flying_bullet_speed
	
	add_child(m_flying_bullet)
	m_flying_bullet.global_position = PlayerManager.get_player_global_position() - Vector2(0+offset_x,400)
	m_flying_bullet.global_position.x = clampf(m_flying_bullet.global_position.x , 0, 384)
	m_flying_bullet.launch()

func summon_weak_homing_bullet_enemy(wait_time:float ,m_start_on:String, m_end_on:String, m_offset_x:float, m_offset_y:float, m_speed_increase_value:float = 1, m_max_speed:Vector2 = Vector2(50,50), piviot_point:float = 54,  m_stop_shooting_after:float = 10.0):
	await get_tree().create_timer(wait_time).timeout
	var m_homing_bullet_enemy = weak_homing_bullet_enemy.instantiate()
	m_homing_bullet_enemy.summon(m_start_on, m_end_on, m_offset_x, m_offset_y, m_speed_increase_value, m_max_speed, piviot_point)
	add_child(m_homing_bullet_enemy)
	m_homing_bullet_enemy.stop_shooting( m_stop_shooting_after)

func summon_sin_ray_enemy(m_start_position:Vector2, m_end_position:Vector2, m_position_lerp_speed:float, m_exit_time:float):
	var m_enemy = sin_ray_enemy.instantiate()
	m_enemy.summon(m_start_position, m_end_position, m_position_lerp_speed, m_exit_time) 
	
	add_child(m_enemy)

func summon_normal_spinner_enemy(m_start_position:Vector2,\
 m_end_position:Vector2,\
 m_position_lerp_speed:float,\
 m_exit_time:float,\
m_bullet_rotation_speed:float,\
  m_spinner_rotation_value:float,\
 m_spinner_starting_rotation:float,\
 m_bullet_spawn_cooldown:float):
	var m_enemy = spinner_enemy.instantiate()
	m_enemy.summon(m_start_position, m_end_position, m_position_lerp_speed, m_exit_time)
	
	add_child(m_enemy)
	m_enemy.summon_move_spinner(m_bullet_rotation_speed,\
	m_spinner_rotation_value,\
	m_spinner_starting_rotation,\
	m_bullet_spawn_cooldown)
	add_child(m_enemy)
	m_enemy.summon_move_spinner(-m_bullet_rotation_speed,\
	-m_spinner_rotation_value,\
	m_spinner_starting_rotation + 180,\
	m_bullet_spawn_cooldown)
