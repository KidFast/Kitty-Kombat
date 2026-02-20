extends CharacterBody2D

@export var speed = 400
@export var player_number : int

const jump_velocity = -400 

func get_input():
	var input_direction
	if(player_number == 1):
		input_direction = Input.get_vector("p1_left", "p1_right", "p1_up", "p1_down")
	elif(player_number == 2):
		input_direction = Input.get_vector("p2_left", "p2_right", "p2_up", "p2_down")
	
	velocity = input_direction * speed

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	get_input()
	move_and_slide()
