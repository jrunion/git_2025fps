extends TestState
class_name TestChase

@onready var enemy: CharacterBody3D = get_parent().get_parent()                 #get the enemy body
@onready var sight: Area3D = enemy.get_node("LineOfSight")                      #get the line of sight area
@onready var PlayerPointer: RayCast3D = sight.get_node("PlayerPointer")         #Get the raycast that points to the player
@onready var overlapping = null                                                 #overlapping var, this will count how many things are in the LOS

var player: CharacterBody3D = null                                              #player character body, will grab at start

var lastKnownPosition : Vector3                                                 #last know position, this will take the coordinates of the last place the player was seen
var distance : int                                                              #Distance from player
var timeSet: float =10.0                                                        #timer for how long until you give up looking for the player, this should be changeable
var lostTimer : float = timeSet                                                 #lost timer grabs the publically available timer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player") #Grab first node that is in the "Player" Group. This can be set when selecting a node, and choosing the Node tab next to inspector.
	lastKnownPosition = player.global_position                                  #the last known player position at the start of a chase will obviously be wherever the player is at the start
	PlayerPointer.rotation.y = clamp(PlayerPointer.rotation.y, -180, 0)         #make sure the player pointer is pointer at the player

func process(delta: float):
	enemy.nav_agent.set_target_position(lastKnownPosition)                       #using the enemy's nav agent, set target to last known position
	overlapping = sight.get_overlapping_bodies()                                 #get the overlapping bodies from the enemy sight
	PlayerPointer.rotation.y = clamp(PlayerPointer.rotation.y, -180, 0)         #point the raycast pointer at the player

	
	
	if PlayerPointer.is_colliding():                                                #if the raycast is colliding with something
		var collision = PlayerPointer.get_collider()                                #Collision is the 1st node being collided with
		if collision.name  == "Player":                                             #if the collision name is player
			lastKnownPosition = player.global_position                              #the last know position is the players current position
			lostTimer = timeSet                                                     #reset timer

	if lostTimer <=0:                                                               #if timer hits zero, transition to return state
		emit_signal("Transitioned", self, "TestReturn")
	
	
	if !overlapping.has(player):                                                    #if overlapping isn't player, remove 1 second from timer 
		lostTimer -= delta
		
	
	

func physics_process(delta: float) -> void:
	if enemy.nav_agent.is_navigation_finished():                                          #if nav agent is done, return
		return
	
	
	PlayerPointer.target_position = PlayerPointer.to_local(player.global_position)                  #make pointer the players global position

	var next_position = enemy.nav_agent.get_next_path_position()                             #get the next position
	enemy.look_at(Vector3(lastKnownPosition), Vector3.UP)                                    #look at the last known position
	enemy.velocity = enemy.global_position.direction_to(next_position) * enemy.RunSpeed      #move towards next position at enemy's run speed
