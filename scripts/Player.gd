extends CharacterBody2D

@export var speed: float = 220.0
@export var jump_velocity: float = 600.0
@export var accel: float = 8000.0
@export var gravity_scale: float = 1.0
@export var air_control: float = 0.5
@export var control_enabled: bool = true

var start_position: Vector2

func _ready() -> void:
	start_position = global_position

func _physics_process(delta: float) -> void:
	var gravity := ProjectSettings.get_setting("physics/2d/default_gravity") as float

	var x := Input.get_axis("ui_left", "ui_right")
	if not control_enabled:
		x = 0.0

	velocity.x = move_toward(velocity.x, x * speed, accel * delta * (1.0 if is_on_floor() else air_control))

	if control_enabled and is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_velocity

	if not is_on_floor():
		velocity.y += gravity * gravity_scale * delta

	move_and_slide()

	if global_position.y > 2000.0:
		var target := start_position
		if Game.has_respawn:
			target = Vector2(Game.respawn_position.x, Game.respawn_position.y)

		global_position = target
		velocity = Vector2.ZERO
