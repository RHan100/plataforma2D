extends Node2D
@onready var player: CharacterBody2D = $player
#@onready var camera: Camera2D = $camera
@onready var hud: CanvasLayer = $HUD
#@onready var control_2: Control = $control2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	
	var control_2 = hud.get_node("control2")
	control_2.time_is_up.connect(end_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func end_game():
	await get_tree().create_timer(1.0).timeout
	#get_tree().reload_current_scene()
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
