extends Node

@onready var leftPlayer_score_label = $leftPlayer_score
@onready var rightPlayer_score_label = $rightPlayer_score
@onready var leftPaddle = $paddle
@onready var rightPaddle = $paddle2
@onready var ball = $ball
@onready var winner_label = $winnerLabel
@onready var new_game = $newGameButton

var leftPlayer_score = 0
var rightPlayer_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	leftPlayer_score_label.text = "0"
	rightPlayer_score_label.text = "0"
	ball.position = Vector2(577,328)
	winner_label.hide()
	new_game.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_left_border_body_entered(body: Node2D) -> void:
	rightPlayer_score += 1
	update_score_labels()
	check_score()
	ball.position = Vector2(577,328)
	#ball.stop_ball()


func _on_right_border_body_entered(body: Node2D) -> void:
	leftPlayer_score += 1
	update_score_labels()
	check_score()
	ball.position = Vector2(577,328)
	#ball.stop_ball()
	

func update_score_labels() -> void:
	leftPlayer_score_label.text = str(leftPlayer_score)
	rightPlayer_score_label.text = str(rightPlayer_score)
	
func check_score() -> void:
	var winner_message
	if leftPlayer_score == 5 or rightPlayer_score == 5:
		if leftPlayer_score > rightPlayer_score:
			winner_message = "Left Player Wins!"
		else:
			winner_message = "Right Player Wins!"
		winner_label.text = winner_message
		winner_label.visible = true
		new_game.visible = true
		ball.stop_ball()
			

func _on_new_game_button_pressed() -> void:
	new_game.hide()
	winner_label.hide()
	leftPlayer_score = 0
	rightPlayer_score = 0
	ball.position = Vector2(577,328)
	leftPaddle.position = Vector2(223,226)
	rightPaddle.position = Vector2(872,226)
	update_score_labels()
	ball.velocity = Vector2(-10,0)
