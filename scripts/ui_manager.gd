extends Control
# Controls the in-game UI.

# Public variables
var is_paused:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	GameController.connect("score_updated", self, "_update_score")
	GameController.connect("game_ended", self, "_display_end_of_game")
	$Front/EndScreen/Button.connect("pressed", GameController, "display_main_menu")


# Called when an input event occurs
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if is_paused:
			GameController.unpause_game()
			$Front/PauseScreen.visible = false
			is_paused = false
		else:
			GameController.pause_game()
			$Front/PauseScreen.visible = true
			is_paused = true


# Updates the score display
func _update_score(val):
	$Score.text = "%02d" % val;


# Displays a menu with end of game information.
func _display_end_of_game():
	$Front/EndScreen/Score.text = "%02d" % GameController.score
	$Front/EndScreen.visible = true
	$Tween.interpolate_property($Front/EndScreen, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
