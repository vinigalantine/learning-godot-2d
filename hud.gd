extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait for the MessageTimer count
	await  $MessageTimer.timeout
	
	$Message.text = "Dodge if you can!"
	$Message.show()
	# Make an one-shot timer and wait for it
	await get_tree().create_timer(1.0).timeout
	# create_timer() is an alternative for the Timer node
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_mesage_timer_timeout():
	$Message.hide()
