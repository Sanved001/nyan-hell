extends Node2D
@onready var stage_1_bg: Sprite2D = $Stage1_Bg


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if stage_1_bg.position.y <= 2644:
		stage_1_bg.position.y += 25*delta
	
