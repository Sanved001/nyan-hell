extends Node2D
@onready var stage_1_bg: Sprite2D = $Stage1_Bg

var stage_music = preload("res://Assets/DO_NOT_PUSH/assets/BGM/banjo_something.mp3")
var boss_music = preload("res://Assets/DO_NOT_PUSH/assets/BGM/f_d.mp3")
var flying_bullet = preload("res://Scenes/entities/flying_bullet.tscn")
var weak_homing_bullet_enemy = preload("res://Scenes/Enemies/weak_homing_bullet_enemy.tscn")

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
var minus1900:bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if stage_1_bg.position.y <= 2644:
		stage_1_bg.position.y += 50*delta

	if not minus1900:
		if -1900.0 < stage_1_bg.position.y:
			minus1900 = true
			summon_Flying_Bullet(0.2, 500)
			
			var x_offset_list = [0.0, 25.0, 50.0]
			for m_XOL in x_offset_list: 
				# TOP LEFT TO BOTTOM RIGHT
				for i in range(8):
					summon_weak_homing_bullet_enemy(i*2, "top_left", "right", m_XOL, 0.0, 10, Vector2(100,100), 0)
				# TOP RIGHT TO BOTTOM LEFT
				for i in range(8):
					summon_weak_homing_bullet_enemy(i*2, "top_right", "left", m_XOL, 0.0, 10, Vector2(100,100), 0)




	if 2525.0 < stage_1_bg.position.y:
		if stage_music_toggle == false:
			stage_music_toggle = true
			Bgm.stop()
			#Bgm.stream = boss_music
			#Bgm.play()
		
		

func summon_Flying_Bullet(wait_time:float, flying_bullet_speed:float, offset_x:float = 0.0):
	await get_tree().create_timer(wait_time).timeout
	var m_flying_bullet = flying_bullet.instantiate()
	
	m_flying_bullet.my_speed = flying_bullet_speed
	
	add_child(m_flying_bullet)
	m_flying_bullet.global_position = PlayerManager.get_player_global_position() - Vector2(0+offset_x,400)
	m_flying_bullet.global_position.x = clampf(m_flying_bullet.global_position.x , 0, 384)
	m_flying_bullet.launch()

func summon_weak_homing_bullet_enemy(wait_time:float ,m_start_on:String, m_end_on:String, m_offset_x:float, m_offset_y:float, m_speed_increase_value:float = 1, m_max_speed:Vector2 = Vector2(50,50), piviot_point:float = 54):
	await get_tree().create_timer(wait_time).timeout
	var m_homing_bullet_enemy = weak_homing_bullet_enemy.instantiate()
	m_homing_bullet_enemy.summon(m_start_on, m_end_on, m_offset_x, m_offset_y, m_speed_increase_value, m_max_speed, piviot_point)
	add_child(m_homing_bullet_enemy)
