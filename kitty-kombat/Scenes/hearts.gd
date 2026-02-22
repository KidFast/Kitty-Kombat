extends Node2D

@onready var group1 = $"group1"
@onready var group2 = $"group2"
@onready var group3 = $"group3"

@onready var heart1 = $"group1/heart1"
@onready var heart2 = $"group1/heart2"
@onready var heart3 = $"group1/heart3"
@onready var heart4 = $"group2/heart4"
@onready var heart5 = $"group2/heart5"
@onready var heart6 = $"group2/heart6"
@onready var heart7 = $"group3/heart7"
@onready var heart8 = $"group3/heart8"
@onready var heart9 = $"group3/heart9"

var has_group1 = true
var has_group2 = true
var has_group3 = true

func round_lost():
	if has_group3:
		heart9.texture = preload("res://Sprites/healthBar/empty_heart.png")
		heart8.texture = preload("res://Sprites/healthBar/empty_heart.png")
		heart7.texture = preload("res://Sprites/healthBar/empty_heart.png")
	elif has_group2:
		heart6.texture = preload("res://Sprites/healthBar/empty_heart.png")
		heart5.texture = preload("res://Sprites/healthBar/empty_heart.png")
		heart4.texture = preload("res://Sprites/healthBar/empty_heart.png")
	elif has_group1:
		heart3.texture = preload("res://Sprites/healthBar/empty_heart.png")
		heart2.texture = preload("res://Sprites/healthBar/empty_heart.png")
		heart1.texture = preload("res://Sprites/healthBar/empty_heart.png")
