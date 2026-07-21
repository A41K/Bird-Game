extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if has_node("/root/GameManager"):
			get_node("/root/GameManager").add_score(1)
		set_deferred("monitoring", false)
