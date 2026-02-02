extends Node

var respawn_position := Vector3(0, 0, 0)
var has_respawn := false
var win := false

func set_respawn(pos: Vector3) -> void:
	respawn_position = pos
	has_respawn = true

func reset_run_state() -> void:
	win = false
	has_respawn = false
	respawn_position = Vector3(0, 0, 0)
