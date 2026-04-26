extends Node2D

var enemy_scene = preload("res://scenes/enemy.tscn")

func _ready() -> void:
	for i in range(16):
		Level.wave = 1
		spawn_enemy_in_circle()
		await get_tree().create_timer(0.2).timeout

func _physics_process(delta: float) -> void:
	if get_tree().get_node_count_in_group("enemy") == 0 and Level.wave > 0:
		print("wave compleate")

func spawn_enemy_in_circle():	
	var enemy = enemy_scene.instantiate()
	
	var angle = randf_range(0, 2 * PI)
	
	var spawn_pos = Vector2(
		cos(angle) * Level.enemy_spawn_radius,
		sin(angle) * Level.enemy_spawn_radius
	)
	
	enemy.position = global_position + spawn_pos
	get_tree().current_scene.add_child.call_deferred(enemy)
