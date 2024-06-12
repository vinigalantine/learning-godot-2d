extends CanvasLayer

var row = preload("res://rank/row.tscn")
@onready var rowsContainer = get_node("TableControl/Table/Rows/ColorRect/ScrollContainer/VBoxContainer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generateRow(data: Dictionary, count: int):
	var row = row.instantiate()
	row.name = str(count)
	
	rowsContainer.add_child(row)
	
	get_node("TableControl/Table/Rows/ColorRect/ScrollContainer/VBoxContainer/"+row.name+"/UserLabel").text = data.user
	get_node("TableControl/Table/Rows/ColorRect/ScrollContainer/VBoxContainer/"+row.name+"/ScoreLabel").text = str(data.score)
	
