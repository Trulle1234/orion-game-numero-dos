extends Sprite2D

@onready var bullet_start: Node2D = $BulletStart

const BULLET = preload("uid://b5r1ketveva1g")

func _ready() -> void:
	add_to_group("cannon")
 
func shoot():
	var b = BULLET.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_transform = bullet_start.global_transform
