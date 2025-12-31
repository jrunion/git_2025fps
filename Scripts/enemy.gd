extends CharacterBody3D

var player: CharacterBody3D = null



@export var WalkSpeed = 4
@export var RunSpeed = 6
@export var Weight = 5
const RayLength = 1000
const RayAngle = 45

@export var player_path : NodePath

@onready var raycastStraight = RayCast3D.new()
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var detectedPlayer: bool 

#called when node enters scene tree for the first time
func _ready():
	detectedPlayer = false
	player = get_node(player_path)
	
	
	
	raycastStraight.owner=self
	raycastStraight.target_position = Vector3(10,10,10)
	raycastStraight.enabled=true
	raycastStraight.debug_shape_custom_color = Color(0.953, 0.0, 0.702)
	raycastStraight.debug_shape_thickness = 4
	raycastStraight.force_raycast_update()
	add_child(raycastStraight)


#called every frame
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	#nav_agent.set_target_position(player.global_transform.origin)

	#var next_nav_point = nav_agent.get_next_path_position()
	#if detectedPlayer:
	#	velocity = (next_nav_point - global_transform.origin).normalized() * WalkSpeed
	#	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	
		
	
	
	

func _physics_process(delta):
	
	#raycastStraight.force_raycast_update()
	#if not is_on_floor():
	#	velocity += get_gravity() * delta * Weight
		
	raycastStraight.force_raycast_update() 
	process_move()
	
func process_move() -> void:
	#if nav_agent.is_navigation_finished():
	#	return
	
	move_and_slide()
	
	
	
