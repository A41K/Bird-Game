extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var game_over_screen: CanvasLayer = $GameOverScreen


func _ready() -> void:
	player.died.connect(_on_player_died)
	game_over_screen.restart_pressed.connect(_on_restart_pressed)


func _on_player_died() -> void:
	get_tree().paused = true
	var score: int = 0
	if has_node("/root/GameManager"):
		score = GameManager.score
	game_over_screen.show_game_over(score)


func _on_restart_pressed() -> void:
	get_tree().paused = false
	if has_node("/root/GameManager"):
		GameManager.reset_score()
	get_tree().reload_current_scene()
