extends Node2D

const PIPE_SCENE := preload("res://scenes/Pipe.tscn")

@export var spawn_interval: float = 1.4       
@export var gap_size: float = 220.0            
@export var min_gap_size: float = 110.0     
@export var shrink_per_pipe: float = 4.0       
@export var spawn_ahead_distance: float = 700.0
@export var gap_y_range: Vector2 = Vector2(150, 450)

var rng := RandomNumberGenerator.new()
var player: Node2D


func _ready() -> void:
	rng.randomize()
	player = get_tree().get_first_node_in_group("player")

	var timer := Timer.new()
	timer.wait_time = spawn_interval
	timer.autostart = true
	timer.timeout.connect(_spawn_pipe)
	add_child(timer)

	_spawn_pipe() 


func _spawn_pipe() -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		if player == null:
			return  

	var pipe := PIPE_SCENE.instantiate()
	add_child(pipe)
	pipe.global_position.x = player.global_position.x + spawn_ahead_distance
	pipe.configure(rng.randf_range(gap_y_range.x, gap_y_range.y), gap_size)

	gap_size = max(min_gap_size, gap_size - shrink_per_pipe)
