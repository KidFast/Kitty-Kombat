extends CharacterBody2D

@export var player_number : int
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar : ProgressBar = $health_bar
@onready var hitbox : Area2D = $hitbox
@onready var hurtbox : Area2D = $hurtbox

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

func _ready():
	add_to_group("sofiCat")
	hitbox.add_to_group("sofiCat_hitbox")
	hurtbox.add_to_group("sofiCat_hurtbox")
	
	animated_sprite.animation_finished.connect(_on_animation_finished)
	
	health_bar.init_health(health)



func _on_animation_finished():
	if animated_sprite.animation in ["light_attack", "heavy_attack"]:
		attacking = false
		hit_box_active = false
		
		if velocity == Vector2.ZERO:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walking")

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
		animated_sprite.play("light_attack")
	
	if Input.is_action_just_pressed("p%s_heavy_attack" % [player_number]) and not attacking:
		attacking = true
		hit_box_active = true
		attack_damage = heavy_attack_dmg
		velocity.x = 0
		animated_sprite.play("heavy_attack")
	
	dash()
	get_input()
	move_and_slide()


func _on_hitbox_area_entered(area: Area2D):
	if not hit_box_active:
		return
	
	if area.is_in_group("nerdCat_hurtbox"):
		var opponent = area.owner
		opponent.take_damage(attack_damage)

func _on_hurtbox_area_entered(area: Area2D):
	if area.is_in_group("nerdCat_hitbox"):
		take_damage(area.owner.attack_damage)


func take_damage(damage : int):
	health -= damage
	health_bar._set_health(health)
