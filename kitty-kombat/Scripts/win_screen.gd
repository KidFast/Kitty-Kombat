extends Control

@onready var p1 = $"../nerdCat"
@onready var p2 = $"../sofiCat"

func _ready() -> void:
	call_deferred("_set_winner_text")
	
func determine_winner():
	if p1.win_status == 1:
		print(p1.cat_name)
		return p1
	elif p1.win_status == 1:
		print(p2.cat_name)
		return p2

func _set_winner_text():
	$PanelContainer/Label.text = "Player %s is Victorious" % [determine_winner().player_number]

func _on_quit_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scenes/CharacterSelect/character_select.tscn")
