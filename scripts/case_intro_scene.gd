extends Control

@onready var case_text = $CenterContainer/VBoxContainer/CaseText
@onready var continue_button = $CenterContainer/VBoxContainer/ContinueButton

var case_intros = [
	"📁 Caso: Se ha encontrado un equipo sospechoso en la escena de un ciberataque. Tu tarea es preservar las evidencias digitales sin comprometer la integridad de los datos.",
	"📁 Caso: Durante un allanamiento, se incautó un dispositivo que podría contener información sensible. Debes decidir cómo manipularlo correctamente.",
	"📁 Caso: Un empleado es sospechoso de fuga de datos. Su equipo ha sido aislado y ahora es tu responsabilidad iniciar la investigación."
]

func _ready():
	for node in $CenterContainer/VBoxContainer.get_children():
		print(node.name, ": ", node.size)
	
	# Selecciona aleatoriamente una descripción
	case_text.text = case_intros.pick_random()
	for node in get_tree().get_current_scene().get_children():
		print("🔍 Nodo visible:", node.name, " Tipo:", node)

func _on_continue_button_pressed():
	var selector = preload("res://scene_selector.tscn")
	get_tree().change_scene_to_packed(selector)
	
		#var random_scene = [
	#	preload("res://Scenes/GameScene_ComputerOn.tscn"),
	#	preload("res://Scenes/GameScene_ComputerOff.tscn")
	#].pick_random()
