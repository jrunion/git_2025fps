extends Node

@export var MaxHealth = 100

var health = MaxHealth

func damage(attack: Attack) -> void:
	health -= attack.damage
	
	var parent: Node3D = get_parent()
	if parent.has_method("on_damaage")
		parent.on_damage(attack)
		
		if health <= 0:
			parent.on_death()
