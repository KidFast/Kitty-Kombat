extends Control

@onready var PlayerButton_Scene = preload("res://InputSettings/input_settings.tscn")
@onready var option_list = $PanelContainer/MarginContainer/OptionList
# Called when the node enters the scene tree for the first time.
var is_selected = false


func _ready():
	_create_player_list()
	
func _create_player_list():
	InputMap.load_from_project_settings()
	for item in option_list.get_children():
			item.queue_free()
			
	for option in InputMap.get_actions():
		var button = PlayerButton_Scene.instantiate()
		var option_label = button.find_child("PlayerLabel")
		
		option_label.text = option
		
		var events = InputMap.action_get_events(option)
		if events.size() > 0:
			option_label.text = events[0].as_text()
		else:
			option_label.text = ""
			
		player_list.add_child(button)
		
	
