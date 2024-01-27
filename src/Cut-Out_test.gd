extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# These two would be visible while choosing the word - and the true would turn to false when the correct choice is made.
	$IdleMan.visible = true
	
	#Here starts the first animation.
	$FallingMan.visible = true
	$TreeDog.visible = true
	
	get_node("FallingMan").play("Fall")
	get_node("TreeDog").play("Run")
	get_node("FallingManAnimation").play("Man-falls")
	get_node("TreeDogAnimation").play("new_animation")
	
	#Here starts the second animation.
	$Treebottom.visible = true
	$RunningDog.visible = true
	$FallingMan2.visible = true
	
	get_node("RunningDog").play("Running")
	get_node("FallingMan2").play("Falling")
	get_node("FallingMan2Animation").play("Exploding Tree")
	get_node("FullDogAnimation").play("RunningDogFull")
	
	#Here is the third.
	$Tree.visible = true
	
	get_node("Tree/FallingMan3").play("Fall3")
	get_node("Tree/ClimbingDog").play("Climb")
	get_node("ClimbingAnimation").play("ClimbingUp")
	
	#Here is the fourth one.
	$IntactTree.visible = true
	
	get_node("IntactTree/SpringyMan").play("Spring")
	get_node("IntactTree/SpringyDog").play("SpringDog")
	get_node("SpringyManAnimation").play("Springy-Man")
	get_node("TreeDogAnimation").play("Springy-Dog")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
