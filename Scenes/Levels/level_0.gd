extends Node2D
@onready var stage_1_bg: Sprite2D = $Stage1_Bg

var boss_music = preload("res://Assets/DO_NOT_PUSH/assets/BGM/f_d.mp3")
var flying_bullet = preload("res://Scenes/entities/flying_bullet.tscn")
var weak_homing_bullet_enemy = preload("res://Scenes/Enemies/weak_homing_bullet_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
			
			# Going Right
			summon_weak_homing_bullet_enemy("top_left", "right", 0.0, 0.0)
			summon_weak_homing_bullet_enemy("top_right", "right", 0.0, 30.0)
			summon_weak_homing_bullet_enemy("top_right", "right", 0.0, -30.0)
			summon_weak_homing_bullet_enemy("left", "right", 0.0, 10.0)
			summon_weak_homing_bullet_enemy("left", "right", 0.0, -10.0)
			summon_weak_homing_bullet_enemy("right", "right", 0.0, 20.0)
			summon_weak_homing_bullet_enemy("right", "right", 0.0, -20.0)

			# Going Left
			summon_weak_homing_bullet_enemy("top_left", "left", 0.0, -50.0)
			summon_weak_homing_bullet_enemy("top_right", "left", 0.0, -140.0)
			summon_weak_homing_bullet_enemy("top_right", "left", 0.0, -70.0)
			summon_weak_homing_bullet_enemy("left", "left", 0.0, -65.0)
			summon_weak_homing_bullet_enemy("left", "left", 0.0, -55.0)
			summon_weak_homing_bullet_enemy("right", "left", 0.0, 65.0)
			summon_weak_homing_bullet_enemy("right", "left", 0.0, -55.0)
			# Going Left
			summon_weak_homing_bullet_enemy("top_left", "left", 10.0, -55.0)
			summon_weak_homing_bullet_enemy("top_right", "left", 30.0, -140.0)
			summon_weak_homing_bullet_enemy("top_right", "left", 30.0, -70.0)
			summon_weak_homing_bullet_enemy("left", "left", 30.0, -65.0)
			summon_weak_homing_bullet_enemy("left", "left", 30.0, -55.0)
			summon_weak_homing_bullet_enemy("right", "left", 30.0, 65.0)
			summon_weak_homing_bullet_enemy("right", "left", 30.0, -55.0)
		
		
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

func summon_weak_homing_bullet_enemy(m_start_on:String, m_end_on:String, m_offset_x:float, m_offset_y:float):
	var m_homing_bullet_enemy = weak_homing_bullet_enemy.instantiate()
	m_homing_bullet_enemy.summon(m_start_on, m_end_on, m_offset_x, m_offset_y)
	add_child(m_homing_bullet_enemy)
