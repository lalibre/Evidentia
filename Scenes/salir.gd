extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset_resultados() -> void:
	Game_Manager.aciertos = 0
	Game_Manager.fallos = 0
	Game_Manager.puntuacion
	
func _on_pressed() -> void:
	reset_resultados()
	get_tree().change_scene_to_file("res://Scenes/scene_selector.tscn")
