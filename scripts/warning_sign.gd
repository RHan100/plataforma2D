extends Node2D

@onready var texture: Sprite2D = $texture
@onready var area_sign: Area2D = $area_sign

const lines: Array[String] = [
	"Olá comprista!",
	"Sua missão é comprar 5 Iphones e 5 Perfumes",
	"Iphones custam 20 moedas, perfumes custam 7",
	"Não se deixe enganar pelos piranhitas",
	"Se você morrer vai perder todo o dinheiro e itens"
]

func _unhandled_input(event):
	if area_sign.get_overlapping_bodies().size() >0:
		texture.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			texture.hide()
			DialogManager.start_message(global_position, lines)
	else:
		texture.hide()
		#if DialogManager.dialog_box != null:
			#DialogManager.dialog_box.dismiss_dialog_box.emit()
			#DialogManager.is_message_active= false
		
