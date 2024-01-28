extends Control

var easy_theme = Theme.new()
@export var easy_font: Font
# Called when the node enters the scene tree for the first time.
func _ready():
	if global.simple_font:
		easy_theme.set_default_font(easy_font)
		easy_theme.set_default_font_size(13)
		set_theme(easy_theme)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Cut-Out_test.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Credits.tscn")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Menu.tscn")
