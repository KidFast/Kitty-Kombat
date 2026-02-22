extends Node2D


var playerWin = false

@onready var spawn_p1 = Vector2(485, 492)
@onready var spawn_p2 = Vector2(1237, 641)

#Before i forget I will write down the point of thise
#When a player wins this will have a player win condition that will go true if a player won
func _ready() -> void:
	var p1_char : Resource = GameData.p1_character
	var p2_char : Resource = GameData.p2_character
	
	var p1_scene = load(p1_char.scene_path)
	var p2_scene = load(p2_char.scene_path)
	
	var p1_instance = p1_scene.instantiate()
	p1_instance.global_position
	endGame()
	

func endGame():
	if playerWin:
		get_tree().change_scene_to_file("res://Scenes/CharacterSelect/character_select.tscn")
