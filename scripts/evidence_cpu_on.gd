extends EvidenciaBase 

func _ready():
	input_pickable = true
	tipo = "CPU"
	estado = "encendida"
	#print("ClickableArea ready")
	print("EvidenceArea listo:", tipo, "Estado:", estado)


func _on_boton_guardar_pressed() -> void:
	pass # Replace with function body.


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("¡Hiciste clic en el cpu on")
	if event is InputEventMouseButton and event.pressed:
		print("¡Hiciste clic en el cpu on")


func _on_mouse_entered() -> void:
	print("¡mouse entro")
