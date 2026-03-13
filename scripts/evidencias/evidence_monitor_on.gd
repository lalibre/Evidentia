extends EvidenciaBase

@export var sprite_encendido: Texture2D
@export var sprite_apagado: Texture2D
@onready var sprite = $Sprite2D

func _ready():
	input_pickable = true
	tipo = "monitor"
	estado_cambiado.connect(_actualizar_sprite)
	_actualizar_sprite(estado_actual)  # Inicializa correctamente el sprite

func _actualizar_sprite(estado):
	match estado:
		Estado.ENCENDIDO:
			sprite.texture = sprite_encendido
		Estado.APAGADO:
			sprite.texture = sprite_apagado
			sprite.scale = Vector2(0.9, 0.9)
		_:
			pass  # Otros estados no cambian la imagen

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		var menu = get_parent().get_node("EvidenciaMenu")
		menu.mostrar_menu(self, get_global_mouse_position(), estado_actual)


func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
