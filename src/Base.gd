extends Node2D
@export_file var limeric_file

var spot = preload("res://Text_Spot.tscn")
var text_drag = preload("res://Dragable_Text.tscn")
#indicates amount of verses in poem
var verse = 0
#indicates amount of solved verses in poem
var solved  = -1
var lines
var lines_n = 5
#indicates last visible line of the poem
var last_visible = 0
	
func _ready():
	solved = -1
	verse = 0
	var file = FileAccess.open(limeric_file, FileAccess.READ)
	var limeric = file.get_as_text()
	lines = limeric.split("\n")
	for i in lines_n:
		var line
		line = find_child(("Line_" + str(i)))
		line.text = lines[i]
		if lines[i].contains("___"):
			var new_spot = spot.instantiate()
			#Create all spot Disabled by default
			#Named iteratively
			new_spot.position = line.position
			add_child(new_spot)
			new_spot.name = ("spot" +str(verse))
			verse +=1
	solved +=1
	_create_options()
	_adjust_verse("null")


func _create_options ():
	if solved == verse:
		#Win
		pass
	else:
		var options =lines[solved+5].split(",")
		var test = ("spot" +str(solved))
		var active_spot = get_node(test)
		active_spot.get_node("CollisionShape2D").set_disabled(false)
		active_spot.answer = options[0]
		active_spot.active = true
		var counter = 0
		for i in options:
			var new_text = text_drag.instantiate()
			new_text._set_Text(i)
			new_text._set_spot(Vector2(100*counter,300.0))
			add_child(new_text)
			counter +=1
	
func _adjust_verse(answer):
	if(last_visible != 0):
		lines[last_visible].replace("___",answer)
	var hide = false
	for i in lines_n:
		var line = find_child(("Line_" + str(i)))
		line.text = lines[i]
		if hide:
			line.visible = false
		else:
			line.visible = true
		if line.text.contains("___"):
			last_visible = i
			hide = true
