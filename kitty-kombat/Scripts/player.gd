extends CharacterBody2D

@export var player_number : int
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar : ProgressBar = $health_bar
@onready var hitbox_left : Area2D = $hitbox_left
@onready var hitbox_right : Area2D = $hitbox_right
@onready var hitbox_left_collision = $hitbox_left/hitbox_left_collision
@onready var hitbox_right_collision = $hitbox_right/hitbox_right_collision
@onready var hurtbox : Area2D = $hurtbox
@export var character : Character

@export var cat_name : String
var facing_direction = 1
var win_status = 1		#1 = winner   0 = loser

#movement variables
@export var speed = 400
@export var dash_speed = 1400

const jump_velocity = -1200

var dash_direction = Vector2(1,0)
var can_dash = true
var dashing = false

var attacking = false

#fight variables
var health = 100
var attack_damage = 0
var light_attack_dmg = 5
var heavy_attack_dmg = 15
var hit_box_active = false

var winningPlayer = 1

func _ready():
	add_to_group("%s" % [cat_name])
	hitbox_left.add_to_group("%s_hitbox" % [cat_name])
	hitbox_right.add_to_group("%s_hitbox" % [cat_name])
	hurtbox.add_to_group("%s_hurtbox" % [cat_name])
	
	animated_sprite.animation_finished.connect(_on_animation_finished)
	
	health_bar.init_health(health)
	
	hitbox_left_collision.disabled = true
	hitbox_right_collision.disabled = true

func _on_animation_finished():
	if animated_sprite.animation in ["light_attack", "heavy_attack"]:
		attacking = false
		hit_box_active = false
		#hitbox.position.x = 0
		
		if velocity == Vector2.ZERO:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walking")
		
		hitbox_left_collision.disabled = true
		hitbox_right_collision.disabled = true

#dash mechanic
func dash():
	if dashing:
		return
	
	if is_on_floor():
		can_dash = true
	
	if Input.is_action_pressed("p%s_left" % [player_number]):
		dash_direction = Vector2(-1,0)
	
	if Input.is_action_pressed("p%s_right" % [player_number]):
		dash_direction = Vector2(1,0)
	
	if Input.is_action_just_pressed("p%s_dash" % [player_number]) and can_dash:
		velocity = dash_direction * dash_speed
		can_dash = false
		dashing = true
		await get_tree().create_timer(0.2).timeout
		dashing = false
	
#getting movement input
func get_input():
	if dashing or attacking:			#doesn't accept input while dashing or attacking
		return
	
	if velocity == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walking")
	
	var input_direction
	input_direction = Input.get_vector("p%s_left" % [player_number], "p%s_right" % [player_number], "p%s_up" % [player_number], "p%s_down" % [player_number])
	
	velocity.x = input_direction.x * speed
	
	if input_direction.x != 0:
		facing_direction = sign(input_direction.x)
		animated_sprite.flip_h = (facing_direction == 1)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	if Input.is_action_just_pressed("p%s_up" % [player_number]) and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_just_pressed("p%s_light_attack" % [player_number]) and not attacking:
		attacking = true
		hit_box_active = true
		attack_damage = light_attack_dmg
		velocity.x = 0
		if facing_direction == -1:
			hitbox_left_collision.disabled = false
		else:
			hitbox_right_collision.disabled = false
		
		animated_sprite.play("light_attack")
	
	if Input.is_action_just_pressed("p%s_heavy_attack" % [player_number]) and not attacking:
		attacking = true
		hit_box_active = true
		attack_damage = heavy_attack_dmg
		velocity.x = 0
		if facing_direction == -1:
			hitbox_left_collision.disabled = false
		else:
			hitbox_right_collision.disabled = false
		animated_sprite.play("heavy_attack")
	
	
	dash()
	get_input()
	move_and_slide()


func _on_hitbox_area_entered(area: Area2D):
	if area.get_parent() == self:
		return
	
	if not hit_box_active:
		return
		
	var opponent_name = area.owner.cat_name
	
	if area.is_in_group("%s_hurtbox" % opponent_name):
		var opponent = area.get_parent()
		if opponent != self:
			opponent.take_damage(attack_damage)
		

func _on_hurtbox_area_entered(area: Area2D):
	if area.get_parent() == self:
		return
		
	var opponent_name = area.owner.cat_name
	if area.is_in_group("%s_hitbox" % opponent_name):
		var attacker = area.get_parent()
		
		if attacker != self:
			if attacker.hit_box_active:
				take_damage(area.owner.attack_damage)


func take_damage(damage : int):
	health -= damage
	if(health < 0): health = 0
	checkHealth()
	health_bar.health = health

#Win con thinking right now. If the current player health is 0 then they lose and the winner is the other player
func checkHealth():
	if health == 0:
		win_status = 0
		call_deferred("_change_to_win_screen")

func _change_to_win_screen():
	$"../WinScreen".visible = true
