extends CanvasLayer

@onready var score_label: Label = $ScoreLabel


func _ready() -> void:
	if has_node("/root/GameManager"):
		score_label.text = "Score: %d" % GameManager.score
		GameManager.score_changed.connect(_on_score_changed)
	else:
		push_warning("HUD.gd: GameManager autoload not found. Project Settings -> Autoload -> add GameManager.gd, name it 'GameManager'.")


func _on_score_changed(new_score: int) -> void:
	score_label.text = "Score: %d" % new_score
