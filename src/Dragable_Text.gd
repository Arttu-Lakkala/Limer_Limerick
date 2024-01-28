extends Node2D

var active = false
var is_inside_spot = false
var body_ref
var mouse_offset: Vector2
var option
var start_position =Vector2 (0.0, 0.0)
var easy_theme = Theme.new()
signal wrong_answer
signal correct_answer
@export var easy_font: Font
# Called when the node enters the scene tree for the first time.
func _ready():
	if global.simple_font:
		easy_theme.set_default_font(easy_font)
		easy_theme.set_default_font_size(13)
		get_node("Content").set_theme(easy_theme)
	
func _set_Text(source):
	get_node("Content").text = source
	option = source
	
func _set_spot(start):
	start_position = start
	position = start
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if active:
		# activates on starting to drag
		if Input.is_action_just_pressed("click"):
			global.is_draging = true
			mouse_offset = get_global_mouse_position() - global_position
		# active whenever dragging
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - mouse_offset
		#activates when mouse released
		elif Input.is_action_just_released("click"):
			global.is_draging = false
			if is_inside_spot:
				_check_answer(body_ref.answer)
			var mover = get_tree().create_tween()
			mover.tween_property(self, "position", start_position, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered():
	if not global.is_draging:
		active = true
		#Might neeed to be mor complcated
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited():
	if not global.is_draging:
		active = false
		#Might neeed to be mor complcated
		scale = Vector2(1.00, 1.00)


func _on_area_2d_body_entered(body: StaticBody2D):
	if(body.is_in_group('Text_Spots')):
		is_inside_spot = true
		body_ref = body

func _on_area_2d_body_exited(body):
	if(body.is_in_group('Text_Spots')):
		is_inside_spot = false
		body_ref = body

func _check_answer(answer):
	if (answer == option):
		correct_answer.emit(answer)
	else:
		wrong_answer.emit()
		
		
