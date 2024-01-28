extends Node2D
var limeric_file

var spot = preload("res://Text_Spot.tscn")
var text_drag = preload("res://Dragable_Text.tscn")
#indicates amount of verses in poem
var verse = 0
#indicates amount of solved verses in poem
var solved  = -1
var lines
var lines_n = 5
var texts = [Node]
var spots = [Node]
#indicates last visible line of the poem
var last_visible

signal win
	
func _ready():
	texts.clear()
	spots.clear()
	solved = -1
	last_visible = 0
	verse = 0
	var limeric_file = ("res://Limerick/Verse"+str(global.level+1)+".txt")
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
			spots.append(new_spot)
			verse +=1
	solved +=1
	_create_options()
	_adjust_verse("null")
	print_debug(global.level)

func _create_options ():
	var options =Array(lines[solved+5].split(","))
	var active_spot = get_node("spot" +str(solved))
	active_spot.get_node("CollisionShape2D").set_disabled(false)
	active_spot.answer = options[0]
	active_spot.active = true
	options.shuffle()
	var counter = 0
	for i in options:
		var new_text = text_drag.instantiate()
		new_text._set_Text(i)
		new_text._set_spot(Vector2(100*counter,300.0))
		new_text.correct_answer.connect(_next_verse)
		new_text.wrong_answer.connect(_notify_mistake)
		add_child(new_text)
		counter +=1
		print_debug(i)
		texts.append(new_text)
		
#DESTRoy options and hide all locations
func _destroy_options():
	for text in texts:
		text.queue_free()
	texts.clear()
	for spot in spots:
		spot.active = false
		spot.get_node("CollisionShape2D").set_disabled(true)
	
func _adjust_verse(answer):
	if(last_visible != 0):
		lines[last_visible] = lines[last_visible].replace("___",answer)
	var hide = false
	for i in lines_n:
		print_debug(lines[i])
		var line = find_child(("Line_" + str(i)))
		line.text = lines[i]
		if hide:
			line.visible = false
		else:
			line.visible = true
			if line.text.contains("___"):
				last_visible = i
				hide = true

func _next_verse(answer):
	solved +=1
	_adjust_verse(answer)
	_destroy_options()
	if solved == verse:
		win.emit()
		global.level += 1
		if global.level == 4:
			#Win
			pass
		else:
			_ready()
	else:
		$Point_audio.play()
		_create_options()
	
func _notify_mistake():
	$Error_audio.play()
		
