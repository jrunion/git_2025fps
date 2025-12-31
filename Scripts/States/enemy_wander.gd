extends State
class_name EnemyWander

var wander_direction: Vector3
var wander_time: float = 0.0

@onready var enemy: CharacterBody3D = get_parent().get_parent()
var player: CharacterBody3D = null                                                 #creaates a characterbody3D var named player and its empty

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player") #Grab first node that is in the "Player" Group. This can be set when selecting a node, and choosing the Node tab next to inspector.

func randomize_variables():
	if randi_range(0,3) != 1:                                                                 #if the random range from 0-3 isn't 1 (so a 3 in 4 chance you will do the thing), make wanter direction a random vector3, with the first and last being a random float between the number of -1 and 1
		wander_direction = Vector3(randf_range(-1.0,1.0), 0.0, randf_range(-1.0,1.0))
	wander_time = randf_range(1.5,4)    

func enter():
	randomize_variables()

func process(delta: float):
	if wander_time < 0.0:
		randomize_variables()
	
	wander_time -= delta
	
	#change this to if the player is seen using probably the Raycast function
	#if enemy.global_position.distance_to(player.global_position) < enemy.ChaseDistance:       #if the player is the chase distance from enemy or less, emit the signal that changes state to chase
	#	emit_signal("Transitioned", self, "EnemyChase")

func physics_process(_delta: float):                                                                               #enemy velocity is wander Direction * the enemy's walkspeed. so point toward the direction and move that fast
	enemy.velocity = wander_direction * enemy.WalkSpeed
	enemy.look_at(Vector3(wander_direction.x*360, enemy.global_position.y, wander_direction.z*360), Vector3.UP)     #enemy looks at wander_direction time 360 to properly make the value match its needed rotation that it is moving in
	
	if not enemy.is_on_floor():                                                                #if the enemy is not on the floor, make that mother fucker drop
		enemy.velocity += enemy.get_gravity()
