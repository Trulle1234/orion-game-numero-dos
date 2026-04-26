extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var label: Label = $Label
@onready var coins: Label = $Coins

@onready var shooting_button: Button = $ShootingButton
@onready var cannon_button: Button = $CannonButton
@onready var health_bar: ProgressBar = $HealthBar

signal add_cannon

func _process(delta: float) -> void:
	coins.text = str(Level.coins)
	
	health_bar.value = Level.health
	
	if Level.coins < 32 and Level.shoot_cooldown >= 0.01:
		shooting_button.disabled = true
	else:
		shooting_button.disabled = false
	
	if Level.coins < 64 and Level.cannons <= 8:
		cannon_button.disabled = true
	else:
		cannon_button.disabled = false

func _on_enemy_spawner_new_wave() -> void:
	animation_player.play("wave")
	label.text = "WAVE " + str(Level.wave)

	Level.game_state = "wait_for_wave" 
	
	await get_tree().create_timer(2).timeout

	Level.game_state = "play_wave" 

func _on_shooting_button_pressed() -> void:
	if Level.coins >= 32 and Level.shoot_cooldown >= 0.01:
		Level.shoot_cooldown -= 0.01
		Level.coins -= 32
	
func _on_cannon_button_pressed() -> void:
	if Level.coins >= 64 and Level.cannons <= 8:
		add_cannon.emit()
		Level.coins -= 64
