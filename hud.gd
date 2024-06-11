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
	show_score_save_hud()
	
func show_score_save_hud():
	$Message.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	$Message.text = "What's your name?"
	$Message.show()
	
	$NamePlayerScore.show()
	$NamePlayerScore.grab_focus()
	$SaveButton.show()
	
func save_score():
	var usr : String = $NamePlayerScore.text
	
	if $Message.text == "WHAT'S YOUURRR NAME?" && (usr == "" || usr == null):
		$Message.text = "Tony? 👀"
	elif usr == "" || usr == null:
		#var font = $Message.
		$Message.add_theme_font_size_override("font_size",45)
		$Message.text = "WHAT'S YOUURRR NAME?"
	else:
		var score = int($ScoreLabel.text)
		
		if !FileAccess.file_exists("user://rank.json"):
			var baseRank = "{ \"rank\": [] }"
			var firstRank = FileAccess.open("user://rank.json",FileAccess.WRITE)
			firstRank.store_string(baseRank)
			firstRank.close()
		
		var rankFile = FileAccess.open("user://rank.json", FileAccess.READ_WRITE)
		
		if rankFile.get_as_text() != "" || rankFile.get_as_text() != null:
			var rankParse : Dictionary = JSON.parse_string(rankFile.get_as_text())
			var userRank = { "user": usr, "score": score }
			
			rankParse["rank"].append( userRank )
			
			rankFile.store_string(JSON.stringify(rankParse))
			rankFile.close()
		
		$NamePlayerScore.clear()
		$NamePlayerScore.hide()
		$SaveButton.hide()
		show_new_game()

func show_new_game():
	$Message.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	$Message.add_theme_font_size_override("font_size",65)
	$Message.text = "Dodge if you can!"
	$ScoreLabel.text = "0"
	$Message.show()
	# Make an one-shot timer and wait for it
	await get_tree().create_timer(1.0).timeout
	# create_timer() is an alternative for the Timer node
	$StartButton.show()
	$SeeRankButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	$SeeRankButton.hide()
	start_game.emit()

func _on_mesage_timer_timeout():
	$Message.hide()

func _on_name_player_score_text_changed(new_text):
	var caret_column = $NamePlayerScore.caret_column
	$NamePlayerScore.text = new_text.to_upper()
	$NamePlayerScore.caret_column = caret_column

func _on_name_player_score_text_submitted(new_text):
	save_score()
