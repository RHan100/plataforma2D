extends Area2D

var iphone := 1
@export var cost := 7

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
		queue_free()
		Globals.iphones += iphone
	
	
	#await $collision.call_deferred("queue_free")
#
#func _on_anim_animation_finished() -> void:
	#queue_free()
