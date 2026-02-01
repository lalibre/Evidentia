extends Control

@onready var guardar_btn = $BottomButtonPanel/BotonGuardar
@onready var volver_btn = $BottomButtonPanel/BotonAyuda

func _ready():
	pass

func _on_boton_salir_pressed():
	Game_Manager.cambiar_a_scene_selector()


func _on_ayuda_pressed():
	print("Mostrar ayuda...") # aquí puedes abrir un Popup con tips
	
func _on_guardar_pressed():
	if Game_Manager:
		Game_Manager.guardar_bitacora_en_archivo()
		print("Bitácora guardada desde OptionsPanel")


func _on_boton_guardar_pressed() -> void:
	print("Guardando en bitacora")
	Game_Manager.guardar_bitacora_en_archivo()


func _on_boton_ayuda_pressed() -> void:
	print("Mostrar ayuda presed") # aquí puedes abrir un Popup con tips
	# Replace with function body.
