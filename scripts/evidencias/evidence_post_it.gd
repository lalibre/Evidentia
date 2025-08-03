extends Area2D

func _ready():
	input_pickable = true
	print("EvidenceArea ready")

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("¡Hiciste clic en el postit")
