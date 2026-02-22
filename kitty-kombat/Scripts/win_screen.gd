extends Control

@onready var p1 = $sofiCat
@onready var p2 = $nerdCat

func determine_winner():
	if(p1.win_status == 1):
		return p1
	else:
		return p2

func _on_quit_button_pressed() -> void:
	$Label.text = "Player %s is Victiorious" % [determine_winner().cat_name]
	get_tree().change_scene_to_file("res://Scenes/CharacterSelect/character_select.tscn")
