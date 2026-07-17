extends CharacterBody2D

# LAYERS:
# LAYER - 1 Player Hurtbox
# LAYER - 2 Enemy HitBox
# LAYER - 3 Enemy Hurtbox
# LAYER - 4 Player HitBox


@export var bullet_offset:float = 10.0
@export var player_sprite:Sprite2D




var player_bullet = preload("res://Scenes/entities/player_bullet.tscn")




var margin_x:float
var margin_y:float
var play_area_size:Vector2






const SPEED = 300.0

func _ready() -> void:
	PlayerManager.player = self
	
	margin_x = (player_sprite.texture.get_size().x * player_sprite.scale.x) / 2
	margin_y = (player_sprite.texture.get_size().y * player_sprite.scale.y) / 2
	if OS.is_debug_build():
		print("Margin Y: %s" % margin_x)
		print("Margin Y: %s" % margin_y)
	
	
	play_area_size = get_viewport_rect().size


func _physics_process(delta: float) -> void:
	
	# MOVEMENT
	var direction_x := Input.get_axis("move_left", "move_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var direction_y := Input.get_axis("move_up", "move_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	# Do not let the player outside of playarea
	position.x = clampf(position.x, margin_x, play_area_size.x - margin_x)
	position.y = clampf(position.y, margin_y, play_area_size.y - margin_y)
	
	# Player Attack
	if Input.is_action_pressed("shoot"):
		Spawn_Bullets()
	
	
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if not area is Hitbox:
		return
	if OS.is_debug_build():
		print("Player Came In contact with Entity:%s" % area.entity_name, "(%s)" % area.entity_type)
	get_tree().reload_current_scene()

# Spawn Bullets
var spawn_bullet_tick:bool = false
func Spawn_Bullets():
	
	
	var m_player_bullet = player_bullet.instantiate()
	
	
	if spawn_bullet_tick:
		m_player_bullet.position.x = bullet_offset
		spawn_bullet_tick = false
	else:
		spawn_bullet_tick = true
		m_player_bullet.position.x = -bullet_offset
	
	add_child(m_player_bullet)
	#m_player.global_position = global_position
