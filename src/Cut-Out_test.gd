extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# These two would be visible while choosing the word - and the true would turn to false when the correct choice is made.
	$IdleMan.visible = true


func _play_animation():
	$IdleMan.visible = false
	match global.level:
		0:
			$FallingMan.visible = true
			$TreeDog.visible = true
			get_node("FallingMan").play("Fall")
			get_node("TreeDog").play("Run")
			get_node("FallingManAnimation").play("Man-falls")
			get_node("TreeDogAnimation").play("new_animation")
			$FallingMan.visible = false
			$TreeDog.visible = false
		1:
			$Treebottom.visible = true
			$RunningDog.visible = true
			$FallingMan2.visible = true
			get_node("RunningDog").play("Running")
			get_node("FallingMan2").play("Falling")
			get_node("FallingMan2Animation").play("Exploding Tree")
			get_node("FullDogAnimation").play("RunningDogFull")
			$Treebottom.visible = false
			$RunningDog.visible = false
			$FallingMan2.visible = false
		2:
			$Tree.visible = true
			get_node("Tree/FallingMan3").play("Fall3")
			get_node("Tree/ClimbingDog").play("Climb")
			get_node("ClimbingAnimation").play("ClimbingUp")
			$Tree.visible = false
		3:
			$IntactTree.visible = true
			get_node("IntactTree/SpringyMan").play("Spring")
			get_node("IntactTree/SpringyDog").play("SpringDog")
			get_node("SpringyManAnimation").play("Springy-Man")
			get_node("TreeDogAnimation").play("Springy-Dog")
			$IntactTree.visible = false
			
	$IdleMan.visible = true
	