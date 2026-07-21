extends CharacterBody2D

@export var gravity_force: float = 900.0
@export var jump_force: float = -300.0
@export var max_fall_speed: float = 600.0
@export var forward_speed: float = 150.0
@export var max_rotation_deg: float = 30.0
@export var rotation_smoothing: float = 6.0
@export var obstacle_layer: int = 2 
@export var jump_ease_time: float = 0.08

@onready var sprite: Node2D = $Sprite2D  

signal died

var is_dead: bool = false


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	velocity.y += gravity_force * delta
	velocity.y = min(velocity.y, max_fall_speed)

	if Input.is_action_just_pressed("jump"):
		_do_jump()

	velocity.x = forward_speed

	move_and_slide()

	var target_rotation: float = clamp(velocity.y / 10.0, -max_rotation_deg, max_rotation_deg)
	sprite.rotation_degrees = lerp(sprite.rotation_degrees, target_rotation, rotation_smoothing * delta)

	for i in get_slide_collision_count():
		_check_collision(get_slide_collision(i))


func _do_jump() -> void:
	var tween := create_tween()
	tween.tween_method(_set_jump_velocity, velocity.y, jump_force, jump_ease_time) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _set_jump_velocity(v: float) -> void:
	velocity.y = v


func _check_collision(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	if collider == null:
		return
	if collider.collision_layer & (1 << (obstacle_layer - 1)):
		die()


func die() -> void:
	if is_dead:
		return
	is_dead = true
	set_physics_process(false)
	emit_signal("died")


func reset(start_position: Vector2) -> void:
	is_dead = false
	velocity = Vector2.ZERO
	global_position = start_position
	rotation_degrees = 0.0
	sprite.rotation_degrees = 0.0
	set_physics_process(true)
