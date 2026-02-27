extends EvidenciaBase 

func _ready():
	input_pickable = true
	tipo = "cajon"
	estado = "reportado"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
