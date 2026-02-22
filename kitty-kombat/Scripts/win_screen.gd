extends Control

var winner = $player.winningPlayer

func _on_quit_button_pressed() -> void:
	$Label.text = "Player %s is Victiorious" % [winner]
	get_tree().change_scene_to_file("res://Scenes/CharacterSelect/character_select.tscn")
