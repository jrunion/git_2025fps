extends TestState
class_name TestReturn

@onready var enemy: CharacterBody3D = get_parent().get_parent()
@onready var sight: Area3D = enemy.get_node("LineOfSight")
@onready var PlayerPointer: RayCast3D = sight.get_node("PlayerPointer")
@onready var overlapping = null
@onready var collision = null

var player: CharacterBody3D = null

var returnPosition : Vector3

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player") #Grab first node that is in the "Player" Group. This can be set when selecting a node, and choosing the Node tab next to inspector.
	returnPosition = enemy.starting_position
	PlayerPointer.rotation.y = clamp(PlayerPointer.rotation.y, -180, 0)


func process(delta: float):
	enemy.nav_agent.set_target_position(returnPosition)
	overlapping = sight.get_overlapping_bodies()
	collision = PlayerPointer.get_collider()                                #Collision is the 1st node being collided with
	
	PlayerPointer.target_position = PlayerPointer.to_local(player.global_position)                 #point Raycast towards player 

	
	if overlapping.size() > 0 && overlapping.has(player) && PlayerPointer.is_colliding() && collision.name  == "Player":                                                                                        #if the raycast is colliding with somethin                                            #if the collision name is player
			emit_signal("Transitioned", self, "TestChase")                          #transition to chase
	
	
	if enemy.global_position.distance_to(returnPosition) < 3 :
		emit_signal("Transitioned", self, "TestWander")                          #transition to chase




func physics_process(delta: float) -> void:
	if enemy.nav_agent.is_navigation_finished():
		return                    #transition to chase
	
	var next_position = enemy.nav_agent.get_next_path_position()
	enemy.look_at(Vector3(returnPosition), Vector3.UP)
	enemy.velocity = enemy.global_position.direction_to(next_position) * enemy.RunSpeed
	
