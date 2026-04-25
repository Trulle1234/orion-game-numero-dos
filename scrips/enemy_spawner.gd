extends Node2D

var enemy_scene = preload("res://scenes/enemy.tscn")

func _ready() -> void:
	for i in range(10):
		spawn_enemy_in_circle()

func spawn_enemy_in_circle():	
	var enemy = enemy_scene.instantiate()
	
	var angle = randf_range(0, 2 * PI)
	
	var spawn_pos = Vector2(
		cos(angle) * Level.enemy_spawn_radius,
		sin(angle) * Level.enemy_spawn_radius
	)
	
	enemy.position = global_position + spawn_pos
	get_tree().current_scene.add_child.call_deferred(enemy)
