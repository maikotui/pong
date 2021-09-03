extends Node2D
# A singleton that provides a global interface for all game objects to utilize.
# This class provides methods for starting/ending and pausing the game. It also
# keeps track of the player's score.


# Signals
signal ball_velocity_changed(new_dir)
signal score_updated(score)
signal game_paused()
signal game_unpaused()
signal game_ended()

# Public variables
enum Side { LEFT, RIGHT }
var score: int = 0
var is_active: bool = false


# Loads the game scene and prepares for the game to start
func start_game():
	get_tree().change_scene("res://game.tscn")
	is_active = true
	score = 0


# Ends the game but does not switch scene. Use display_main_menu to switch scene
func end_game(loser):
	is_active = false
	emit_signal("game_ended")


# Increments the score by one
func increment_score():
	if is_active:
		score += 1
		emit_signal("score_updated", score)


# Pauses the game
func pause_game():
	is_active = false
	emit_signal("game_paused")


# Unpauses the game, logic will still function if the game is not paused
func unpause_game():
	is_active = true
	emit_signal("game_unpaused")


# Switches to the main menu scene
func display_main_menu():
	get_tree().change_scene("res://main_menu.tscn")
	is_active = false
