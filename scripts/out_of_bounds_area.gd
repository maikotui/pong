extends Area2D
# Defines an area that, if entered, should end the game.


# Dictates what side the OOB area is on (left or right)
export(GameController.Side) var side


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self,"_end_game")


# Triggers the end of game when the Area is entered.
func _end_game(_body):
	$GameEndSound.play()
	GameController.end_game(side)
