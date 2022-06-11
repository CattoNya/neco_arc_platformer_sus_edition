extends Node2D

onready var button = $Button
var nextScene = preload("res://World.tscn")

func _ready():
	button.connect("pressed", self, "_button_pressed")
	
func _button_pressed():
	get_tree().change_scene_to(nextScene)
