extends Node2D
@onready var stage_1_bg: Sprite2D = $Stage1_Bg

var boss_music = preload("res://Assets/DO_NOT_PUSH/assets/BGM/f_d.mp3")
var flying_bullet = preload("res://Scenes/entities/flying_bullet.tscn")

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
			summon_Flying_Bullet(2, 500)
			summon_Flying_Bullet(4, 500)
			summon_Flying_Bullet(4.5, 500)
			summon_Flying_Bullet(5, 500)
			summon_Flying_Bullet(5.5, 500)
			summon_Flying_Bullet(6, 500)
			summon_Flying_Bullet(6.2, 500)
			summon_Flying_Bullet(6.4, 500)
			summon_Flying_Bullet(6.6, 500)
			summon_Flying_Bullet(6.8, 500)
			summon_Flying_Bullet(7, 500)
			summon_Flying_Bullet(7.2, 500)
			summon_Flying_Bullet(7.4, 500)
			summon_Flying_Bullet(7.6, 500)
			
			summon_Flying_Bullet(10, 500)
			summon_Flying_Bullet(10, 500, -50)
			summon_Flying_Bullet(10, 500, 50)
		
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
