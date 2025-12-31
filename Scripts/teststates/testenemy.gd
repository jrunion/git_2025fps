extends CharacterBody3D                                 #extends Character Body vars

@export var WalkSpeed: float = 1.5                      #sets walks speed but allows it to be changed in editor
@export var RunSpeed: float = 4.0                       #sets run speed but allows it to be changed in editor
@export var AttackReach: float = 0.5                    #sets attack reach but allows it  to be changed in editor
@export var ChaseDistance: float = 10.0                  #sets chase distance but allows it to be changed in editor

@onready var nav_agent = $NavigationAgent3D 
@onready var eyesight: Area3D = $LineOfSight            #the nav agent is a NavigtationAgent3d type


var player = null                                       #sets player to null


func _ready() -> void:                                            #at ready, find the first node that is apart of the player group
	player = get_tree().get_first_node_in_group("Player")



func _physics_process(_delta: float) -> void:                    #basic move physics
	move_and_slide()



func on_death() -> void:                                        #KILL YOURSELF
	queue_free()
