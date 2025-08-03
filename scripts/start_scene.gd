extends Control

@onready var name_input = $CenterContainer/VBoxContainer/NameInput

func _on_StartButton_pressed():
	if name_input.text.strip_edges() != "":
		Global.player_name = name_input.text.strip_edges()

		# Ir a la escena de introducción del caso
		var intro_scene = preload("res://Scenes/CaseIntroScene.tscn")
		get_tree().change_scene_to_packed(intro_scene)
	else:
		name_input.placeholder_text = "❗ Ingresa tu nombre antes de comenzar"
