extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_confirmation_exit_dialog_canceled() -> void:
	pass # Replace with function body.


func _on_confirmation_exit_dialog_confirmed() -> void:
	var informe_scene = preload("res://Scenes/informe.tscn")
	var informe_instance = informe_scene.instantiate()
	get_tree().current_scene.add_child(informe_instance)
