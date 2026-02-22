extends Control

@onready var p1 = $"../sofiCat"
@onready var p2 = $"../nerdCat"

func determine_winner():
	if p1.win_status == 1:
		print(p1.cat_name)
		return p1
	elif p2.win_status == 1:
		print(p2.cat_name)
		return p2

func _set_winner_text():
	$PanelContainer/Label.text = "Player %s is Victorious" % [determine_winner().player_number]

func _on_quit_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scenes/CharacterSelect/character_select.tscn")
