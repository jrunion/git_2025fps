extends CharacterBody3D                                                 #this is a CharacterBody3D type
class_name Player                                                       #class name is player



const SPEED = 10.0                                                      #creates and sets speed
const JUMP_VELOCITY = 18                                                #creates and sets jump velocity   
const SENSITIVITY = 0.02                                                #creats and sets mouse  sensitivity
const WEIGHT = 4                                                        #creates and sets weight

@onready var head = $Face                                               #when starting, make the head variable the child named Face
@onready var camera = $Face/Camera3D                                    #when starting, make the camera variable the Face's child named Camera 3D

func _ready():                                                          #when starting, set mouse input
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):                                           #mouse movement function
	if event is InputEventMouseMotion:                                  #if moving mouse
		head.rotate_y(-event.relative.x * SENSITIVITY)                  #rotate head based on mouses x movement
		camera.rotate_x(-event.relative.y * SENSITIVITY)                #rotate camera based on mouses Y movement
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))       #limit x rotation to -40 and 60 so you dont break ya neck



func _physics_process(delta: float) -> void:                        #checks physics each frame
	# Add the gravity.
	if not is_on_floor():                                          #if not on floor, fall based on your weight
		velocity += get_gravity() * delta * WEIGHT

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():          #if you press the designated jump button and your on floor, jump
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#inputs can be edited and changed under Project > Project Settings > Input Map
	var input_dir := Input.get_vector("ui_cleft", "ui_cright", "ui_forward", "ui_backward")           #set input directions as designated buttons
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()        #direction is pressed button combos rounded
	if direction:                                                                                    #if direction has value (so button is pressed), move in that direction
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:                                                                                       #otherwise don't move
		velocity.x = 0
		velocity.z = 0

	move_and_slide()
