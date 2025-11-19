extends Node                                                             #inherit Node values
class_name TestState                                                     #class name is TestState
signal Transitioned(state: TestState, new_state_machine: String)         #recieves signal

func enter():                                                            #enter function
	pass

func exit():                                                             #exit function
	pass

func process(_delta: float):                                             #frame by frame function
	pass

func _physics_process(delta: float):                                     #physics based frame by frame function
	pass
