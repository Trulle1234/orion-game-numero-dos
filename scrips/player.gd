extends CharacterBody2D

@onready var kill_box: Area2D = $KillBox

const CANNON = preload("uid://djbqbivgnpoyj")
var cannons = []

const ROTATION_OFFSET = 90

signal game_over

func _ready() -> void:
	var c = CANNON.instantiate()
	add_child(c)
	cannons = get_tree().get_nodes_in_group("cannon")
	
	add_to_group("player")

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	velocity = Vector2()
	
	if Input.is_action_pressed("down"):
		velocity = Vector2(-Level.player_speed, 0).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(Level.player_speed, 0).rotated(rotation)
	
	if Input.is_action_just_pressed("shoot"):
		Level.shoot_timer = 0
	
	if Input.is_action_pressed("shoot"):
		if Level.shoot_timer < 0:
			for c in cannons:
				c.shoot()
			Level.shoot_timer = Level.shoot_cooldown
		else:
			Level.shoot_timer -= delta
	
	move_and_slide()
	
func _process(delta: float) -> void:
	if Level.damage_timer > 0:
		Level.damage_timer -= delta

	if kill_box.has_overlapping_bodies() and Level.damage_timer <= 0:
		Level.health -= 1
		Level.damage_timer = Level.damage_cooldown
		
		modulate = 	Color(3, 0.2, 0.2)
		await get_tree().create_timer(0.15).timeout
		modulate = 	Color(1, 1, 1)
		
		if Level.health <= 0:
			game_over.emit()

func _on_ui_add_cannon() -> void:
	Level.cannons += 1

	var c = CANNON.instantiate()
	add_child(c)

	cannons = get_tree().get_nodes_in_group("cannon")
	update_cannon_rotations()
	
func update_cannon_rotations() -> void:
	var count = cannons.size()
	if count == 0:
		return

	for i in range(count):
		var c = cannons[i]
		c.rotation_degrees = i * 30.0 - count / 2.0 * 30.0 + 15
