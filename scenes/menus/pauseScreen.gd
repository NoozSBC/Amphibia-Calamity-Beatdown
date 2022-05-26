extends Control

enum {BASIC, DROP, VERIFY, OPTIONS}
var state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func despawnPlayer(num):
	pg.playerAlive[num] = false
	get_parent().get_node("Player" + str(num)).queue_free()

func showDropButtons():
	for i in range(0, pg.playerAlive.size()):
		if pg.playerAlive[i]:
			get_node("dropMenu/buttonP" + str(i+1)).disabled = false
		else:
			get_node("dropMenu/buttonP" + str(i+1)).disabled = true

func _process(_delta):
	# handles pause menu appearing/dissapearing
	if (Input.is_action_just_pressed("pause") == true):
		if (get_tree().paused):
			get_tree().paused = false
		else:
			soundManager.playSound("pause")
			get_tree().paused = true
			$basicMenu.show()
			$dropMenu.hide()
			$verifyMenu.hide()
			$optionsMenu.hide()
			$basicMenu/buttonResume.grab_focus()
			state = BASIC
	if (get_tree().paused):
		self.show()
	else:
		self.hide()
	# displays different menus
	match state:
		BASIC:
			$labelMain.text = "PAUSED"
			$basicMenu.show()
			$dropMenu.hide()
			$verifyMenu.hide()
			$optionsMenu.hide()
			if (pg.countPlayers() > 1):
				$basicMenu/buttonDrop.show()
			else:
				$basicMenu/buttonDrop.hide()
		DROP:
			$labelMain.text = "DROP WHICH PLAYER"
			$basicMenu.hide()
			$dropMenu.show()
			$verifyMenu.hide()
			$optionsMenu.hide()
			showDropButtons()
		VERIFY:
			$basicMenu.hide()
			$dropMenu.hide()
			$verifyMenu.show()
			$optionsMenu.hide()
		OPTIONS:
			$basicMenu.hide()
			$dropMenu.hide()
			$verifyMenu.hide()
			$optionsMenu.show()
		


func _on_buttonResume_pressed():
	get_tree().paused = false


func _on_buttonMap_pressed():
	get_tree().paused = false
	pg.backToMapLose()


func _on_buttonDrop_pressed():
	state = DROP
	$dropMenu/buttonBack.grab_focus()


func _on_buttonBack_pressed():
	state = BASIC
	$basicMenu/buttonResume.grab_focus()


func _on_buttonP1_pressed():
	despawnPlayer(0)
	state = BASIC
	$basicMenu/buttonResume.grab_focus()

func _on_buttonP2_pressed():
	despawnPlayer(1)
	state = BASIC
	$basicMenu/buttonResume.grab_focus()

func _on_buttonP3_pressed():
	despawnPlayer(2)
	state = BASIC
	$basicMenu/buttonResume.grab_focus()

func _on_buttonP4_pressed():
	despawnPlayer(3)
	state = BASIC
	$basicMenu/buttonResume.grab_focus()