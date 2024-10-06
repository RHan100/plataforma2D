extends Node2D
@onready var player: CharacterBody2D = $player
@onready var player_scene = preload("res://actors/player.tscn")
#@onready var camera: Camera2D = $camera
@onready var hud: CanvasLayer = $HUD
#@onready var control_2: Control = $control2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player = player
	#Globals.player.follow_camera(camera)
	Globals.initial_player_position = player.position
	Globals.player.player_has_died.connect(reload_game)
	
	var control_2 = hud.get_node("control2")
	control_2.time_is_up.connect(end_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func end_game():
	await get_tree().create_timer(1.0).timeout
	#get_tree().reload_current_scene()
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
func reload_game():
	await get_tree().create_timer(1.0).timeout
	var player = player_scene.instantiate()
	add_child(player)
	Globals.player = player
	#Globals.player.follow_camera(camera)
	Globals.player.position = Globals.initial_player_position
	Globals.player.player_has_died.connect(reload_game)
	
	Globals.coins = 0
	Globals.diamonds = 0
	Globals.score = 0
	Globals.player_life = 3
	
	Globals.respawn_player()
	#get_tree().reload_current_scene()
