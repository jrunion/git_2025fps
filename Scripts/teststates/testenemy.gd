extends CharacterBody3D

@export var MoveSpeed: float = 4.0
@onready var nav_agent = $NavigationAgent3D

@export var player_path : NodePath

var player = null
var AttackReach = 0.5

func _ready() -> void:
	player = get_node(player_path)

func _process(delta: float) -> void:
	nav_agent.set_target_position(player.global_position)
	
	if global_position.distance_to(player.global_position) < AttackReach:
		var attack: Attack = Attack.new(10.0, self)
		player.testhealthcomponentt.damage(attack)


func _physics_process(_delta: float) -> void:
	process_move()


func process_move() -> void:
	if nav_agent.is_navigation_finished():
		return
	
	
	var next_position = nav_agent.get_next_path_position()
	velocity = global_position.direction_to(next_position) * MoveSpeed
	
	move_and_slide()


func on_death() -> void:
	queue_free()
