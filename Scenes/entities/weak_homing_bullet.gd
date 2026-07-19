extends Node2D
@onready var locate_player_timer: Timer = $Locate_Player_Timer


var player_global_position
var speed_multiplyer:float = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_locate_player_timer_timeout()
	#player_global_position = PlayerManager.get_player_global_position()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(0,0)
	position = Vector2(move_toward(position.x, player_global_position.x, speed_multiplyer*delta),\
		move_toward(position.y, player_global_position.y, speed_multiplyer*delta))


func _on_locate_player_timer_timeout() -> void:
	player_global_position = PlayerManager.get_player_global_position()
	var distance_to_player = player_global_position - global_position
	speed_multiplyer = distance_to_player.length()/10
	locate_player_timer.start()
