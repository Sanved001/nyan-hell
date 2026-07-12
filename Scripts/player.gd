extends CharacterBody2D
@export var player_sprite:Sprite2D

var margin_x:float
var margin_y:float
var play_area_size:Vector2



const SPEED = 300.0

func _ready() -> void:
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
	


	move_and_slide()
