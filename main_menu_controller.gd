extends Control


func start_game():
	GameController.start_game()


func quit():
	get_tree().quit(1)
