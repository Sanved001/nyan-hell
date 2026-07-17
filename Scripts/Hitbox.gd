extends Area2D
class_name Hitbox

var entity_name:String
var entity_type:String
var entity_damage:float

func Entity_Name(m_entity_name:String):
	entity_name = m_entity_name
func Entity_Type(m_entity_type:String):
	entity_type = m_entity_type
func Entity_Damage(damage:float):
	entity_damage = damage
