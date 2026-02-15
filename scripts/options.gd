extends Control

@onready var guardar_btn = $BottomButtonPanel/BotonFinalizar
@onready var volver_btn = $BottomButtonPanel/BotonAyuda
@onready var confirm_exit_dialog: ConfirmationDialog = $ConfirmationExitDialog

func _ready():
	pass

func _on_boton_salir_pressed():
	Game_Manager.cambiar_a_scene_selector()

func _on_ayuda_pressed():
	print("Mostrar ayuda...") # aquí puedes abrir un Popup con tips
	
func _on_guardar_pressed():
	if Game_Manager:
		Game_Manager.guardar_bitacora_en_archivo()
		print("Bitácora guardada desde OptionsPanel kkk")

func _on_boton_ayuda_pressed() -> void:
	print("Mostrar ayuda presed") # aquí puedes abrir un Popup con tips
	# Replace with function body.

func _on_boton_finalizar_pressed():
	print("Guardando en bitacora::::::")
	Game_Manager.guardar_bitacora_en_archivo()
	confirm_exit_dialog.popup_centered()
	#Game_Manager.cambiar_a_scene_selector()
