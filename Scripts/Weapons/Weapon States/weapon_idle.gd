class_name WeaponIdle extends WeaponState

func _ready() -> void: 
	return

func _process (delta: float) -> void:
	if not weapon_controller:
		return
	
	if Input.is_action_just_pressed("ui_shoot") and weapon_controller.can_fire():
			print("fire")
			emit_signal("Transitioned", self, "WeaponFire")
	
	if weapon_controller.current_ammo <= 0:
		emit_signal("Transitioned", self, "WeaponEmpty")
