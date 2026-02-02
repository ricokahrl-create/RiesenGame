extends Area2D

func _ready() -> void:
	$Sprite2D.self_modulate = Color(0.9608, 0.6196, 0.0431, 1.0) # aktiv: #F59E0B
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.name != "Player":
		return

	if Game.has_respawn:
		return

	# Respawn etwas über dem Checkpoint, damit man nicht im Boden spawnt
	Game.set_respawn(Vector3(global_position.x, global_position.y - 60.0, 0.0))

	var hud := get_tree().current_scene.get_node_or_null("CanvasLayer/FPS")
	if hud != null:
		hud.text = "CHECKPOINT!"

	$Sprite2D.self_modulate = Color(0.4196, 0.4471, 0.5020, 1.0) # benutzt: #6B7280
