extends Node

@onready var fps_label: Label = $CanvasLayer/FPS

var toast_text := ""
var toast_until_msec := 0
var _last_set_text := ""
var debug_visible := true

func _ready() -> void:
	fps_label.text = "FPS: ..."
	_last_set_text = fps_label.text

func _process(_delta: float) -> void:
	var base := "FPS: %d | WIN: %s | CP: %s | PAUSE: %s" % [
		Engine.get_frames_per_second(),
		str(Game.win),
		str(Game.has_respawn),
		str(get_tree().paused)
	]
	if Input.is_action_just_pressed("pause_game"):
		get_tree().paused = !get_tree().paused

	if Input.is_action_just_pressed("restart_level"):
		Game.win = false
		Game.has_respawn = false
		get_tree().reload_current_scene()

	var now := Time.get_ticks_msec()

	# Wenn ein anderes Script den Label-Text gesetzt hat, merken wir ihn als Toast
	if fps_label.text != _last_set_text and fps_label.text != base:
		toast_text = fps_label.text
		toast_until_msec = now + 1500

	var shown := base
	if now < toast_until_msec and toast_text != "":
		shown = base + "\n" + toast_text
	if Input.is_action_just_pressed("toggle_debug"):
		debug_visible = !debug_visible
		fps_label.visible = debug_visible

	if debug_visible:
		fps_label.text = shown
		_last_set_text = shown

	if Input.is_action_just_pressed("ui_cancel"):
		if Engine.is_editor_hint():
			get_tree().quit(0)
		else:
			get_tree().quit()
