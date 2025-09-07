extends TextureRect

var original_texture: Texture2D = null
var last_slot: TextureRect = null

func _get_drag_data(_at_position):
	# Guardar el estado actual
	original_texture = texture
	last_slot = self

	# Crear preview del drag
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	preview_texture.size = Vector2(40, 40)

	var preview = Control.new()
	preview.add_child(preview_texture)

	set_drag_preview(preview)

	# Vaciar mientras se arrastra
	texture = null

	# La "data" que viaja es la textura
	return original_texture


func _can_drop_data(_pos, data):
	return data is Texture2D


func _drop_data(_pos, data):
	# Si el slot está vacío, acepta la textura
	if texture == null:
		texture = data
		# Marcar este como el último slot válido
		last_slot = self


func _ready():
	connect("drag_ended", Callable(self, "_on_drag_ended"))


func _on_drag_ended(cancelled: bool):
	# Si no cayó en un destino válido, restaurar
	if cancelled and last_slot and last_slot.texture == null and original_texture:
		last_slot.texture = original_texture

	# Limpiar variables temporales
	original_texture = null
