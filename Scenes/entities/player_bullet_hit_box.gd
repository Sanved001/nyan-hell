extends Hitbox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Entity_Name("player_bullet")
	Entity_Type("player_bullet")
	Entity_Damage(10)
