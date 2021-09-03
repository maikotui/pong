extends Control
# Links controls in the main menu UI to the appropriate functions.


# Triggers the start of the game when the start button is clicked
func start_game():
	GameController.start_game()


# Exits the application when the quit button is clicked
func quit():
	get_tree().quit(1)
