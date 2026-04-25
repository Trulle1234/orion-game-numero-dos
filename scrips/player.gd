extends CharacterBody2D

@onready var kill_box: Area2D = $KillBox
@onready var bullet_start: Node2D = $BulletStart

const BULLET = preload("uid://b5r1ketveva1g")

const ROTATION_OFFSET = 90

var health = 10

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
			shoot()
			Level.shoot_timer = Level.shoot_cooldown
		else:
			Level.shoot_timer -= delta
	
	move_and_slide()
	
func _process(delta: float) -> void:
	if Level.damage_timer > 0:
		Level.damage_timer -= delta

	if kill_box.has_overlapping_bodies() and Level.damage_timer <= 0:
		health -= 1
		Level.damage_timer = Level.damage_cooldown

		if health <= 0:
			print("game over")

func shoot():
	var b = BULLET.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_transform = bullet_start.global_transform
