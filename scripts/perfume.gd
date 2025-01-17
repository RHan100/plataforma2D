extends Area2D

var perfume := 1
@export var cost := 7
@onready var collect: AudioStreamPlayer2D = $collect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_body_entered(body: Node2D) -> void:
	#$anim.play("collect")
	if (Globals.coins >= cost):
		Globals.coins -= cost
		Globals.perfumes += perfume
		collect.play()
	
	
	#await $collision.call_deferred("queue_free")
#
#func _on_anim_animation_finished() -> void:
	#queue_free()


func _on_collect_finished() -> void:
	queue_free()
