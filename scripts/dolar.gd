extends Area2D

@export var coins := 1
# Called when the node enters the scene tree for the first time.


func _on_body_entered(body: Node2D) -> void:
	#$anim.play("collect")
	#await $collision.call_deferred("queue_free")
	if (body.name != "player"):
		return
	else:
		Globals.coins += coins
		queue_free()
