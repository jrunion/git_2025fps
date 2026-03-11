extends Node
class_name WeaponState 


var weapon_controller: WeaponController

signal Transitioned(state: WeaponState, new_state_machine: String)         #recieves signal


func _ready() -> void:
	if %WeaponStateMachine and %WeaponStateMachine is WeaponStateMachine:
		weapon_controller = %WeaponStateMachine.weapon_controller
		



func enter():                                                            #enter function
	pass

func exit():                                                             #exit function
	pass

func process(_delta: float):                                             #frame by frame function
	pass

func physics_process(delta: float):                                     #physics based frame by frame function
	pass
