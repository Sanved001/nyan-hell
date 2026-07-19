extends Node2D
@onready var stage_y_label: Label = $UI/STAGE_Y_Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.update_stage_y.connect(update_stage_y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_stage_y(value:float):
	stage_y_label.text = "Y: %s" % value
