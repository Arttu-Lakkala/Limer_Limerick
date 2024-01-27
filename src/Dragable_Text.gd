extends Node2D

var active = false
var is_inside_spot = false
var body_ref
var mouse_offset: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
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
				var mover = get_tree().create_tween()
				mover.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)


func _on_area_2d_mouse_entered():
	if not global.is_draging:
		print_debug(Engine.get_frames_per_second()) 
		active = true
		#Might neeed to be mor complcated
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited():
	if not global.is_draging:
		print_debug("Engine.get_frames_per_second(AAAA") 
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
