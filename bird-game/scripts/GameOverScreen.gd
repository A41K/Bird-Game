extends CanvasLayer

signal restart_pressed

@onready var score_label: Label = $Panel/VBoxContainer/ScoreLabel
@onready var restart_button: Button = $Panel/VBoxContainer/RestartButton


func _ready() -> void:
	hide()
	restart_button.pressed.connect(_on_restart_pressed)


func show_game_over(score: int) -> void:
	score_label.text = "Score: %d" % score
	show()


func _on_restart_pressed() -> void:
	emit_signal("restart_pressed")
