extends Node2D

@onready var top_pipe: StaticBody2D = $TopPipe
@onready var bottom_pipe: StaticBody2D = $BottomPipe
@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D


func _ready() -> void:
	notifier.screen_exited.connect(queue_free)


func configure(gap_y: float, gap_size: float, pipe_height: float = 600.0) -> void:
	top_pipe.position.y = gap_y - gap_size / 2.0 - pipe_height / 2.0
	bottom_pipe.position.y = gap_y + gap_size / 2.0 + pipe_height / 2.0
