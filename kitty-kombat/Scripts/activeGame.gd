extends StaticBody2D

var playerWin = false


#Before i forget I will write down the point of thise
#When a player wins this will have a player win condition that will go true if a player won
func _ready() -> void:
	endGame()
	

func endGame():
	if playerWin:
		get_tree().change_scene_to_file("res://Scenes/CharacterSelect/character_select.tscn")
