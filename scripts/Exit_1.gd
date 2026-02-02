extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.name != "Player":
		return

	# HUD-Text (wir nutzen dein FPS-Label als Anzeige)
	var hud := get_tree().current_scene.get_node_or_null("CanvasLayer/FPS")
	if hud != null:
		hud.text = "ZIEL ERREICHT! (ESC zum Beenden)"

	# Steuerung komplett aus
	body.set("control_enabled", false)

	# Sofort anhalten
	if body is CharacterBody2D:
		(body as CharacterBody2D).velocity = Vector2.ZERO

	Game.win = true
	await get_tree().create_timer(1.0).timeout
	Game.reset_run_state()
	get_tree().reload_current_scene()
