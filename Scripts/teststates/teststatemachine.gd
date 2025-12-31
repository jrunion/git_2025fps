extends Node                                    #Chooses what values this node inherits. In this case, the Node values
class_name StateMachine                         #The name that can be referenced in other scripts

@export var InitialState: TestState             #export means you can change it in editor, this var type is a TestState Node

var current_state: TestState=null               #start with a null current state, which is also a TestState var
var states: Dictionary = {}                     #creates states array, idk why dictionary

func _ready() -> void:                                              #_ready is the first function that runs
	for child in get_children():                                    #gets all states which will be children Nodes in the scene to the TestMachine node
		if child is TestState:                                      #checks if  children are test states
			states[child.name.to_lower()] = child                   #adds  that node to the states array
			child.Transitioned.connect(on_child_transitioned)       #connects all states that are children of the state machine
	if InitialState:                                                #if there is an initial state
		current_state= InitialState                                 #current state is initial state
		InitialState.enter()                                        #go to and run the initial state script


func _process(delta: float) -> void:                                #_process runs every frame
	if current_state:                                               #if theres a current state
		current_state.process(delta)                                #run current states process

func _physics_process(delta: float) -> void:                        #checks physics each frame
	if current_state:                                               #if theres a current state
		current_state.physics_process(delta)                        #run current states physics

func on_child_transitioned(state, new_state_name):                  #checks to make sure state mentioned isn't the current state
	if state != current_state:
		return
	
	var new_state = states[new_state_name.to_lower()]               #turns all state names to lowercase to avoid syntax errors
	
	if current_state:                                              #if current state leave current state
		current_state.exit()
	
	new_state.enter()                                              #enter the new state
	current_state = new_state                                      #current state becomes the new state
