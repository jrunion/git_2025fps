extends TestState
class_name TestChase

@onready var enemy: CharacterBody3D = get_parent().get_parent()
@onready var sight: Area3D = enemy.get_node("LineOfSight")
@onready var PlayerPointer: RayCast3D = sight.get_node("PlayerPointer")
var player: CharacterBody3D = null

var lastKnownPosition : Vector3
var distance : int

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player") #Grab first node that is in the "Player" Group. This can be set when selecting a node, and choosing the Node tab next to inspector.
	lastKnownPosition = player.global_position

func process(delta: float):

	enemy.nav_agent.set_target_position(lastKnownPosition)
	PlayerPointer.look_at(lastKnownPosition + Vector3(0,360,0))                 #point Raycast towards player 
	
	if PlayerPointer.is_colliding():                                                #if the raycast is colliding with something
		var collision = PlayerPointer.get_collider()                                #Collision is the 1st node being collided with
		if collision.name  == "Player":                                             #if the collision name is player
			lastKnownPosition = player.global_position

	
	if enemy.global_position.distance_to(player.global_position) > enemy.ChaseDistance:
		emit_signal("Transitioned", self, "TestWander")

func physics_process(delta: float) -> void:
	if enemy.nav_agent.is_navigation_finished():
		return
	
	
	var next_position = enemy.nav_agent.get_next_path_position()
	enemy.look_at(Vector3(player.global_position.x, enemy.global_position.y, player.global_position.z), Vector3.UP)
	enemy.velocity = enemy.global_position.direction_to(next_position) * enemy.RunSpeed
