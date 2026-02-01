extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_boton_guardar_pressed(toggled_on: bool) -> void:
	print("Guardando en bitacora")
	Game_Manager.guardar_bitacora_en_archivo()
