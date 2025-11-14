extends Node
class_name Attack

var damage = 25
var attacker: Node3D = null

func _init(damage: float, attacker: Node3D) -> void:
	self.damage = damage
	self.attacker = attacker
