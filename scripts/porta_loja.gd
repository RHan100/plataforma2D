extends Area2D

var is_active = true
@onready var porta_fechada: TextureRect = $PortaFechada
@onready var porta_aberta: TextureRect = $PortaAberta
@onready var teleport_marker: Marker2D = $Marker2D

@export var score_required := 100

func _on_body_entered(body: Node2D) -> void:
	if body.name != "player" or is_active:
		return
	teleport_player()
	
func teleport_player():
	Globals.player.position = teleport_marker.global_position

func _process(delta: float) -> void:
	if (Globals.score >= score_required):
		porta_aberta.visible = true
		porta_fechada.visible = false
		is_active = false
