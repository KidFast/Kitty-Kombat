extends CharacterBody2D

@export var speed = 400
@export var player_number : int

const jump_velocity = -400 

func get_input():
	var input_direction
	input_direction = Input.get_vector("p%s_left" % [player_number], "p%s_right" % [player_number], "p%s_up" % [player_number], "p%s_down" % [player_number])
	
	velocity = input_direction * speed

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	get_input()
	move_and_slide()
