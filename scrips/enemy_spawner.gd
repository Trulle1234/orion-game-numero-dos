extends Node2D

var enemy_scene = preload("res://scenes/enemy.tscn")

var enemies = 16
var spawn_time = 0.2

signal new_wave

func _ready() -> void:
	create_wave(enemies, spawn_time)

func _process(delta: float) -> void:

	if Level.game_state == "init_first_wave":
		Level.wave += 1
		new_wave.emit()
	elif Level.game_state == "play_wave" and get_tree().get_node_count_in_group("enemy") == 0:
		Level.wave += 1
		new_wave.emit()
		
		enemies += Level.wave * 2
		spawn_time -= Level.wave * 0.02
		if spawn_time <= 0.05: spawn_time = 0.05
		
		create_wave(enemies, spawn_time)
		
func create_wave(e, time):
	for i in range(e):
		spawn_enemy_in_circle()
		await get_tree().create_timer(time).timeout
		
func spawn_enemy_in_circle():	
	var enemy = enemy_scene.instantiate()
	
	var angle = randf_range(0, 2 * PI)
	
	var spawn_pos = Vector2(
		cos(angle) * Level.enemy_spawn_radius,
		sin(angle) * Level.enemy_spawn_radius
	)
	
	enemy.position = global_position + spawn_pos
	get_tree().current_scene.add_child.call_deferred(enemy)
