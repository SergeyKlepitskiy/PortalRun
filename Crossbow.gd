extends Node2D
var bolt = preload("res://bolt.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.flip_crossbow:
		$AnimatedSprite2D.set_flip_h(true)
	if not Global.flip_crossbow:
		$AnimatedSprite2D.set_flip_h(false)


func _on_timer_timeout():
	$AnimatedSprite2D.play("shoot")
	await get_tree().create_timer(1).timeout 
	$AnimatedSprite2D.play("idle")
	var instance = bolt.instantiate()
	instance.position = $AnimatedSprite2D.position
	add_child(instance)
	print(position)
	print(instance.position)
	


func _on_timer_self_destruct_timeout():
	$".".queue_free()
