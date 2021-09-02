extends Area2D

export(GameController.Side) var side


func _ready():
	connect("body_entered", self,"_end_game")


func _end_game(_body):
	GameController.end_game(side)
