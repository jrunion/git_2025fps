extends CharacterBody3D

var player = null

const SPEED = 4

@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D

#called when node enters scene tree for the first time
func _ready():
	player = get_node(player_path)


#called every frame
func _process(_delta):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	move_and_slide()
	
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
