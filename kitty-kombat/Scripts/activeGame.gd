extends Node2D


var playerWin = false

@onready var spawn_p1 = Vector2(485, 492)
@onready var spawn_p2 = Vector2(1237, 641)

#Before i forget I will write down the point of thise
#When a player wins this will have a player win condition that will go true if a player won
func _ready() -> void:
	var p1_char : Character = GameData.p1_character
	var p2_char : Character = GameData.p2_character
	
	
	var p1_instance = p1_char.cat.instantiate()
	p1_instance.global_position = spawn_p1
	add_child(p1_instance)
	
	var p2_instance = p2_char.cat.instantiate()
	p2_instance.global_position = spawn_p2
	add_child(p1_instance)
	
	endGame()
	

func endGame():
	if playerWin:
		get_tree().change_scene_to_file("res://Scenes/CharacterSelect/character_select.tscn")
