extends Control
# Links controls in the main menu UI to the appropriate functions.


# Triggers the start of the game when the start button is clicked
func start_game():
	$SelectSound.connect("finished", GameController, "start_game", [], $SelectSound.CONNECT_ONESHOT)
	$SelectSound.play()


# Exits the application when the quit button is clicked
func quit():
	$SelectSound.connect("finished", get_tree(), "quit", [1], $SelectSound.CONNECT_ONESHOT)
	$SelectSound.play()
