extends CharacterBody3D

var player: CharacterBody3D = null



@export var WalkSpeed = 4
@export var RunSpeed = 6
@export var Weight = 5

#const RayLength = 1000
#const RayAngle = 45

@onready var health = 10

@export var player_path : NodePath

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var detectedPlayer: bool 

@onready var starting_position: Vector3

#called when node enters scene tree for the first time
func _ready():
	detectedPlayer = false
	player = get_node(player_path)
	starting_position = transform.origin



#called every frame
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	if health <= 0:
		return
	

func _physics_process(delta):
	
	
	process_move()
	
func process_move() -> void:
	
	
	move_and_slide()
	
