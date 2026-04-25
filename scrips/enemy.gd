extends CharacterBody2D

@onready var area_2d: Area2D = $Area2D

var health = 3

func _ready():
	add_to_group("enemy")
	
	modulate = 	Color(1.5, 0.2, 0.2)

func take_damage(hp):
	health -= hp
	modulate = 	Color(2.5, 0.2, 0.2)
	await get_tree().create_timer(0.15).timeout
	modulate = 	Color(1.5, 0.2, 0.2)
	
	if health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	look_at(%Player.position)
	
	if not area_2d.has_overlapping_bodies():
		position += transform.x * Level.enemy_speed * delta
