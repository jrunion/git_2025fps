extends CharacterBody3D

var player = null


@export var WalkSpeed = 4
@export var RunSpeed = 6
@export var Weight = 5

@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D
@onready var detectedPlayer: bool 

#called when node enters scene tree for the first time
func _ready():
	detectedPlayer = true
	player = get_node(player_path)


#called every frame
func _process(delta):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(player.global_transform.origin)

	var next_nav_point = nav_agent.get_next_path_position()
	if detectedPlayer:
		velocity = (next_nav_point - global_transform.origin).normalized() * WalkSpeed
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	if not is_on_floor():
		velocity += get_gravity() * delta * Weight
		
	move_and_slide()
	
	

#func _physics_process(delta: float) -> void:
	# Add the gravity.
	
		
	
