extends Node2D
var orange = preload("res://portal_o.tscn")
var blue = preload("res://portal_b.tscn")
var mouse: Vector2
var orange_instance
var blue_instance
var crossbow = preload("res://crossbow.tscn")
var explosion = preload("res://explosion.tscn")
var star = preload("res://star.tscn")
var orange_cd: bool = false
var blue_cd:  bool = false
var game_over = preload("res://game_over.tscn")
var game_over_node = game_over.instantiate()
var time: int = 0 
func _ready():
	pass # Replaceh function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_click") and not orange_cd:
		if Global.orange_opened:
			orange_instance.queue_free()
			Global.orange_opened = false
		mouse = get_global_mouse_position()
		orange_instance = orange.instantiate()
		orange_instance.position = mouse
		add_child(orange_instance)
		Global.orange_opened = true
		orange_cd = true
		Global.orange_started = true;
		$OrangeCD.start()
	elif orange_cd:
		pass
	if Input.is_action_just_pressed("right_click") and not blue_cd:
		if Global.blue_opened:
			blue_instance.queue_free()
			Global.blue_opened = false
		mouse = get_global_mouse_position()
		blue_instance = blue.instantiate()
		blue_instance.position = mouse
		add_child(blue_instance)
		Global.blue_pos = mouse
		Global.blue_opened = true
		blue_cd = true
		$BlueCD.start()
	elif blue_cd:
		pass
	$ProgressBar.set("value", Global.health)
	if $ProgressBar.value <= 0:
		get_tree().change_scene_to_file("res://game_over.tscn")

	$Score.text = ("Score: " + str(Global.score) + " Time: " + str(Global.time))
	
	
	$ExplosionTimer.set("wait_time", 3/(Global.difficulty+1))


func _on_crossbow_timer_timeout():
	var rng = RandomNumberGenerator.new()
	var x = rng.randf_range(50,1100)
	var y = rng.randf_range(165,608)
	var spawn_location = Vector2(x, y)
	
	var instance = crossbow.instantiate()
	if x >= 575:
		Global.flip_crossbow = true
		Global.flip_bolt = true
	if x < 575:
		Global.flip_crossbow = false
		Global.flip_bolt = false
	
	instance.position = spawn_location
	add_child(instance)





func _on_explosion_timer_timeout():
	var rng = RandomNumberGenerator.new()
	var x = rng.randf_range(50,1100)
	var y = rng.randf_range(165,608)
	var spawn_location = Vector2(x, y)
	
	var instance = explosion.instantiate()
	
	
	instance.position = spawn_location
	add_child(instance)


func _on_orange_cd_timeout():
	orange_cd = false


func _on_blue_cd_timeout():
	blue_cd = false


func _on_star_timer_timeout():
	var rng = RandomNumberGenerator.new()
	var x = rng.randf_range(50,1100)
	var y = rng.randf_range(165,608)
	var spawn_location = Vector2(x, y)
	
	var instance = star.instantiate()
	
	
	instance.position = spawn_location
	add_child(instance)
	


func _on_health_damage_timeout():
	Global.health -= 1


func _on_difficulty_timeout():
	Global.difficulty += 1
	print(Global.difficulty)


func _on_elapsed_time_timeout():
	Global.time += 1
