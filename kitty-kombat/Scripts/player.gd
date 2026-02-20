extends CharacterBody2D

@export var speed = 400
@export var player_number : int 

func get_input():
	var input_direction
	input_direction = Input.get_vector("p%s_left" % [player_number], "p%s_right" % [player_number], "p%s_up" % [player_number], "p%s_down" % [player_number])
	
	velocity = input_direction * speed

func _physics_process(delta):
		get_input()
		move_and_slide()
