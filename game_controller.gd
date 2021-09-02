extends Node2D

enum Side { LEFT, RIGHT }

signal ball_velocity_changed(new_dir)
signal score_updated(score)
signal game_paused()
signal game_unpaused()
signal game_ended()

var score: int = 0
var is_active: bool = false

func start_game():
	get_tree().change_scene("res://main.tscn")
	is_active = true
	score = 0


func increment_score():
	if is_active:
		score += 1
		emit_signal("score_updated", score)


func end_game(loser):
	is_active = false
	emit_signal("game_ended")


func pause_game():
	is_active = false
	emit_signal("game_paused")


func unpause_game():
	is_active = true
	emit_signal("game_unpaused")


func display_main_menu():
	get_tree().change_scene("res://main_menu.tscn")
