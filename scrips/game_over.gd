extends Control

@onready var label: Label = $Label
@onready var respawn_button: Button = $RespawnButton

func _ready() -> void:
	label.visible = false
	respawn_button.visible = false
	
func _on_respawn_button_pressed() -> void:
	Level.restart()

func _on_player_game_over() -> void:
	label.visible = true
	respawn_button.visible = true
