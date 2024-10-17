extends Node2D
@export var speed: int = 1000
var direction: Vector2 = Vector2.RIGHT



func _ready():
	pass

func _process(delta):
	position += direction * speed * delta
	if Global.flip_bolt:
		direction = Vector2.LEFT
	if not Global.flip_bolt:
		direction = Vector2.RIGHT
func _on_area_2d_body_entered(body):
	Global.health -= 10
