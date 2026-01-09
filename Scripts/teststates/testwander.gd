extends TestState                                              #extends the test state script
class_name TestWander                                          #class name is test wander

var  wander_direction: Vector3                                 #creates a vector3 var called wander direction
var wander_time: float = 0.0                                   #creates a float called wander time

@onready var enemy: CharacterBody3D = get_parent().get_parent()                #creates an enemy at the start that is characterbody3D and is the parent of this childs parent
@onready var sight: Area3D = enemy.get_node("LineOfSight")
@onready var PlayerPointer: RayCast3D = sight.get_node("PlayerPointer")
@onready var overlapping = null
@onready var collision = null
var player: CharacterBody3D = null                                                 #creates a characterbody3D var named player and its empty

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player") #Grab first node that is in the "Player" Group. This can be set when selecting a node, and choosing the Node tab next to inspector.

func randomize_variables():                                                                   #this function randomizes variabled
	if randi_range(0,3) != 1:                                                                 #if the random range from 0-3 isn't 1 (so a 3 in 4 chance you will do the thing), make wanter direction a random vector3, with the first and last being a random float between the number of -1 and 1
		wander_direction = Vector3(randf_range(-1.0,1.0), 0.0, randf_range(-1.0,1.0))
	wander_time = randf_range(1.5,4)                                                          #wander time is a random float between 1.5 and 4

func enter():                                                                                 #when you start, randomize variabled
	randomize_variables()

func process(delta: float):                                                               
	overlapping = sight.get_overlapping_bodies()
	collision = PlayerPointer.get_collider()                                #Collision is the 1st node being collided with

	if wander_time < 0.0:                                                                    #if wander time falls below 0.0, randomize the variables
		randomize_variables()
	
	wander_time -= delta                                                                      #wander time is losing a a fraction of a second every frame
	
	PlayerPointer.look_at(player.global_position + Vector3(0,180,0))                 #point Raycast towards player 
	
	if overlapping.size() > 0 && overlapping.has(player) && PlayerPointer.is_colliding() && collision.name  == "Player":                                                                                        #if the raycast is colliding with somethin                                            #if the collision name is player
			emit_signal("Transitioned", self, "TestChase")                          #transition to chase

	
	#if enemy.global_position.distance_to(player.global_position) < enemy.ChaseDistance:       #if the player is the chase distance from enemy or less, emit the signal that changes state to chase
	#if overlapping.size() > 0:
	#	for overlap in overlapping:                                                            #Check every item that is overlapping
	#		if overlap.name == "Player":                                                       #check if overlapped item has the name Player
	#			PlayerPointer.look_at(player.global_position + Vector3(0,180,0))                 #point Raycast towards player 
	#			if PlayerPointer.is_colliding():                                                #if the raycast is colliding with something
	#				var collision = PlayerPointer.get_collider()                                #Collision is the 1st node being collided with
	#				if collision.name  == "Player":                                             #if the collision name is player
	#					emit_signal("Transitioned", self, "TestChase")                          #transition to chase
		

	

func physics_process(_delta: float):                                                                               #enemy velocity is wander Direction * the enemy's walkspeed. so point toward the direction and move that fast
	enemy.velocity = wander_direction * enemy.WalkSpeed
	enemy.look_at(Vector3(wander_direction.x*360, enemy.global_position.y, wander_direction.z*360), Vector3.UP)     #enemy looks at wander_direction time 360 to properly make the value match its needed rotation that it is moving in
	
	if not enemy.is_on_floor():                                                                #if the enemy is not on the floor, make that mother fucker drop
		enemy.velocity += enemy.get_gravity()
