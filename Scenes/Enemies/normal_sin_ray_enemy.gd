extends Node2D

var sin_ray = preload("res://Scenes/moves/sin_ray.tscn") 

@onready var summon_cooldown_timer: Timer = $Summon_Cooldown_Timer


@export var summon_cooldown:float = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	summon_cooldown_timer.start(summon_cooldown)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func summon_move_sinray():
	var sin_ray_instance = sin_ray.instantiate()
	
	#get_parent().add_child(spinner_instance)
	add_child(sin_ray_instance)
	sin_ray_instance.summon()
	sin_ray_instance.global_position = global_position


func disown_child(child:Node2D):
	if not is_instance_valid(child):
		return
	get_parent().add_child(child)


#func _on_summon_cooldown_timeout() -> void:
	


func _on_summon_cooldown_timer_timeout() -> void:
	summon_move_sinray()
	summon_cooldown_timer.start(summon_cooldown)
