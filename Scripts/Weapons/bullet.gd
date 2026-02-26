extends Node

@onready var bulleType: float
@onready var bulletSpeed: float = 100
@onready var bulletDamage: float = 5

@onready var ray =$RayCast3D

func _ready(): 
	pass
	

func process(_delta: float):
	# += transform.basis * Vector3(0,0,-bulletSpeed) * _delta
	pass
	#if hit
	#if enemy
	#do damage
	#delete
	

func _physics_process(delta: float) -> void:                        #checks physics each frame
	pass
	#move in line (maybe change depending on gun)
	
