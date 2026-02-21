extends Control

var characters = ["NerdCat", "SofiCat"]

var p1_selection := 0
var p2_selection := 0

var p1_confirmed := false
var p2_confirmed := false

@onready var OptionList = $OptionList
@onready var option_buttons = OptionList.get_children()

@onready var p1_highlight = $P1Highlight
@onready var p2_highlight = $P2Highlight
@onready var p1_ready_label = $P1ReadyLabel
@onready var p2_ready_label = $P2ReadyLabel

func _ready():
		assert(option_buttons.size() == characters.size())
		call_deferred("update_visuals")

func _process(delta):
	
	if not p1_confirmed:
		if Input.is_action_just_pressed("p1_left"):
			p1_selection = wrapi(p1_selection - 1, 0, characters.size())
			update_visuals()
		elif Input.is_action_just_pressed("p1_right"):
			p1_selection = wrapi(p1_selection + 1, 0, characters.size())
			update_visuals()
		elif Input.is_action_just_pressed("p1_light_attack"):
			p1_confirmed = true
			update_visuals()
		elif Input.is_action_just_pressed("p1_heavy_attack"):
			p1_confirmed = false
			update_visuals()
			
	if not p2_confirmed:
		if Input.is_action_just_pressed("p2_left"):
			p2_selection = wrapi(p2_selection - 1, 0, characters.size())
			update_visuals()
		elif Input.is_action_just_pressed("p2_right"):
			p2_selection = wrapi(p2_selection + 1, 0, characters.size())
			update_visuals()
		elif Input.is_action_just_pressed("p2_light_attack"):
			p2_confirmed = true
			update_visuals()
		elif Input.is_action_just_pressed("p2_heavy_attack"):
			p2_confirmed = false
			update_visuals()
			
			
		
func update_visuals():
	
	if option_buttons.size() > 0:
		var p1_button = option_buttons[p1_selection]
		var p2_button = option_buttons[p2_selection]
		
		p1_highlight.global_position = p1_button.global_position
		p2_highlight.global_position = p2_button.global_position
		
		p1_highlight.size = p1_button.size
		p2_highlight.size = p2_button.size
		
		if p1_ready_label:
			p1_ready_label.visible = p1_confirmed
		if p2_ready_label:
			p2_ready_label.visible = p2_confirmed
	
	
