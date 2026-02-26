extends CharacterBody3D                                                 #this is a CharacterBody3D type
class_name Player                                                       #class name is player



const SPEED = 10.0                                                      #creates and sets speed
const JUMP_VELOCITY = 18                                                #creates and sets jump velocity   
const SENSITIVITY = 0.02                                                #creats and sets mouse  sensitivity
const WEIGHT = 4                                                        #creates and sets weight

@onready var playerHealth: float = 100

@onready var heldItem: Node3D
@onready var roundsPerSecond: float = 0.25
@onready var bulletTimer: float = 0

@onready var bulletRange: float = 0

@onready var head = $Face                                               #when starting, make the head variable the child named Face
@onready var camera = $Face/Camera3D                                    #when starting, make the camera variable the Face's child named Camera 3D
@onready var bulletStart = $Face/Camera3D/Gun/Muzzle                    #when starting, make the bullet start variable the end of the default gun

func _ready():                                                          #when starting, set mouse input
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):                                           #mouse movement function
	if event is InputEventMouseMotion:                                  #if moving mouse
		head.rotate_y(-event.relative.x * SENSITIVITY)                  #rotate head based on mouses x movement
		camera.rotate_x(-event.relative.y * SENSITIVITY)                #rotate camera based on mouses Y movement
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))       #limit x rotation to -40 and 60 so you dont break ya neck


func process(delta: float):
	if Input.is_action_just_pressed("ui_shoot"):       #If user is pressing the shoot button 
		shoot()
		if(bulletTimer >0):                            #if bullet timer is great than zero
			bulletTimer -= delta                       #subtract bullet time per second
		else:                                          
			
			bulletTimer = roundsPerSecond              #make bullet timer rounds per second
			

func _physics_process(delta: float) -> void:                        #checks physics each frame
	# Add the gravity.
	if not is_on_floor():                                          #if not on floor, fall based on your weight
		velocity += get_gravity() * delta * WEIGHT
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():          #if you press the designated jump button and your on floor, jump
		velocity.y = JUMP_VELOCITY                                           #You may as well jump, JUMP
	
	
	var input_dir := Input.get_vector("ui_cleft", "ui_cright", "ui_forward", "ui_backward")           #set input directions as designated buttons
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()        #direction is pressed button combos rounded
	if direction:                                                                                    #if direction has value (so button is pressed), move in that direction
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:                                                                                       #otherwise don't move
		velocity.x = 0
		velocity.z = 0

	move_and_slide()
	



func shoot() -> void:
	var space_state: PhysicsDirectBodyState3D = bulletStart.get_world_3D().direct_space_state
	var ray_start: Vector3 = bulletStart.global_position
	
	var ray_direction: Vector3 = -bulletStart.global_basis.z
	var ray_end:Vector3 = ray_start + ray_direction.normalized() * bulletRange
	
	var query:=PhysicsRayQueryParameters3D.create(ray_start,ray_end)
	query.collide_with_bodies = true
	var result: Dictionary = space_state.intersect_rauy(query)
	
	print(result)
