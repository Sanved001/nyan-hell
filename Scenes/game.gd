extends Node2D
@onready var stage_y_label: Label = $UI/STAGE_Y_Label
@onready var invinsible_indicator: ColorRect = $UI/invinsible_indicator


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.update_stage_y.connect(update_stage_y)
	SignalBus.show_invincible_indicator.connect(show_invinsible_indicator)
	invinsible_indicator.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_stage_y(value:float):
	stage_y_label.text = "Y: %s" % value

func show_invinsible_indicator(value:float):
	if value:
		invinsible_indicator.visible = true
	else:
		invinsible_indicator.visible = false
