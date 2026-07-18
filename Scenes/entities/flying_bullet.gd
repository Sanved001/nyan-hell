extends Node2D
@onready var warn_line: ColorRect = $Warn_Line


var my_speed = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	warn_line.visible = false

var launch_var = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if launch_var:
		position.y += my_speed*delta


func launch():
	#warn_line.visible = true
	await get_tree().create_timer(0.1).timeout
	#warn_line.visible = false
	launch_var = true
