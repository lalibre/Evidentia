extends Control

@onready var ayuda_btn = $BottomButtonPanel/BotonAyudaptions/HboxContainer
@onready var guardar_btn = $BottomButtonPanel/BotonGuardar
@onready var volver_btn = $BottomButtonPanel/BotonSalir

func _ready():
	pass

func _on_ayuda_pressed():
	print("Mostrar ayuda...") # aquí puedes abrir un Popup con tips

func _on_guardar_pressed():
	if Game_Manager:
		Game_Manager.guardar_bitacora_en_archivo()
		print("Bitácora guardada desde OptionsPanel")

func _on_boton_salir_pressed():
	Game_Manager.cambiar_a_scene_selector()
