extends Area2D
@onready var normal_sin_ray_enemy: CharacterBody2D = $".."

@export var health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		normal_sin_ray_enemy.queue_free()




func _on_area_entered(area: Area2D) -> void:
	if not area is Hitbox:
		return
	health -= area.entity_damage
