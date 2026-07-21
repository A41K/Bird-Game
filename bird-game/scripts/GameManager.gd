extends Node

signal score_changed(new_score: int)
signal game_over

var score: int = 0


func add_score(amount: int = 1) -> void:
	score += amount
	emit_signal("score_changed", score)


func reset_score() -> void:
	score = 0
	emit_signal("score_changed", score)


func trigger_game_over() -> void:
	emit_signal("game_over")
