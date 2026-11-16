extends CharacterBody2D

var start = false

var speed = 10
var frict = 10
var max_speed = 100 # 100
var x_vel = 0
var x_dir = 0

var slime_dist = 60
var slime_rotate_speed = 1.5

var level = 8
signal level_change(num)
#signal text1
#signal level_down

signal door_prompt # this is now just the arrow prompt, but it used to be only for doors.
signal anti_door_prompt
var right_door_action = false
var left_door_action = false

var vent_action = false
var vent_cutscene = false
var vent_timer = 0
var vent_complete = false
var haskey = false
var room_access = false

var crying_girl_action = false
signal girl_anim
signal crying_text(num)
var crying_convo = 0

var crying_quest = false
var bear_action = false
var hasbear = false
signal pickup_bear()
var give_bear_action = false
signal give_bear
var bear_cutscene = false

signal win

var girltextbox = -1
var slimetextbox = -1
var conversation = 0
var slimetextx = -105
var slimetexty = -43
var girltextx = -135
var girltexty = -43

var slimearray = [
	"this tube is where\n  I escaped from!",
	"       it says there's\n   a key in the vent!",
	"    send me through!",
	"i got it!",
	"we can use the key\nto unlock this door!",
	"there's a bear here!\nlet's take it!",
	"we found your bear!"
	]

var girlarray = [
	"Why do you cry?",
	"Stop. We'll find it.",
	"Now wait.",
	"Here's your bear."
	]

func speedness(dir, vel):
	if dir > 0:
		if vel < max_speed:
			vel += speed
	elif dir < 0:
		if vel > -max_speed:
			vel -= speed
	elif dir == 0:
		if vel > 0:
			vel -= frict
		elif vel < 0:
			vel += frict
	return vel

func level_changing(num, x):
	level = num
	level_change.emit(num)
	if x == "l":
		global_position.x = 25 # end up at the left
		$Girl.flip_h = false
		$Slime.flip_h = false
	if x == "r":
		global_position.x = 1125 # end up at the right
		$Girl.flip_h = true
		$Slime.flip_h = true
	if x == "ld":
		global_position.x = 350 # end up at the left door
	if x == "rd":
		global_position.x = 950 # end up at the right door
	#print(level)
	if num == 2:
		global_position.y = 450
	elif num == 5 or num == 6 or num == 7 or num == 8 or num == 9:
		global_position.y = 425
	else:
		global_position.y = 400
	conversation = 0

func _physics_process(_delta):
	$start_menu/button.play()
	if Input.is_action_just_pressed("ui_up"):
		start = true
		$start_menu/button.visible = false
		$start_menu.visible = false
	#if Input.is_action_just_pressed("ui_down"): # textboxes
	if conversation > 0:
		if conversation > 0 and conversation < 6:
			slimetextbox = conversation - 1
			$Slime/slime_textbox.visible = true
			$Slime/slime_textbox/CanvasLayer/SlimeLabel.visible = true
		if conversation == 6:
			if Input.is_action_just_pressed("ui_up"):
				crying_convo += 1
				if crying_convo == 1:
					$Girl/girl_textbox.visible = true
					$Girl/girl_textbox/CanvasLayer/GirlLabel.visible = true
					girltextbox = 0
				if crying_convo == 2:
					$Girl/girl_textbox.visible = false
					$Girl/girl_textbox/CanvasLayer/GirlLabel.visible = false
					crying_text.emit(1)
					crying_quest = true
				if crying_convo == 3:
					crying_text.emit(2)
				if crying_convo == 4:
					crying_text.emit(3)
				if crying_convo == 5:
					crying_text.emit(0)
					$Girl/girl_textbox.visible = true
					$Girl/girl_textbox/CanvasLayer/GirlLabel.visible = true
					girltextbox = 1
				if crying_convo == 6:
					girltextbox = 2
				if crying_convo == 7:
					crying_convo = 0
					$Girl/girl_textbox.visible = false
					$Girl/girl_textbox/CanvasLayer/GirlLabel.visible = false
		if conversation == 7:
			slimetextbox = 5
			$Slime/slime_textbox.visible = true
			$Slime/slime_textbox/CanvasLayer/SlimeLabel.visible = true
		if conversation == 8:
			if Input.is_action_just_pressed("ui_up"):
				crying_convo += 1
				if crying_convo == 1:
					girltextbox = 3
					slimetextbox = 6
					$Girl/girl_textbox.visible = true
					$Girl/girl_textbox/CanvasLayer/GirlLabel.visible = true
					$Slime/slime_textbox.visible = true
					$Slime/slime_textbox/CanvasLayer/SlimeLabel.visible = true
				if crying_convo == 2:
					$Girl/girl_textbox.visible = false
					$Girl/girl_textbox/CanvasLayer/GirlLabel.visible = false
					$Slime/slime_textbox.visible = false
					$Slime/slime_textbox/CanvasLayer/SlimeLabel.visible = false
					crying_text.emit(4)
				if crying_convo == 3:
					x_dir = 0
					give_bear.emit()
					hasbear = false
					bear_cutscene = true
					crying_text.emit(5)
				if crying_convo == 4:
					anti_door_prompt.emit()
					win.emit()
		$Slime/slime_textbox/CanvasLayer/SlimeLabel.text = slimearray[slimetextbox]
		$Girl/girl_textbox/CanvasLayer/GirlLabel.text = girlarray[girltextbox]
	else:
		crying_text.emit(0)
		$Slime/slime_textbox.visible = false
		$Slime/slime_textbox/CanvasLayer/SlimeLabel.visible = false
		$Girl/girl_textbox.visible = false
		$Girl/girl_textbox/CanvasLayer/GirlLabel.visible = false
		#print(slimearray.size())
		#print(girlarray.size())
		#if slimetextbox == 0: # text cycle
			#$Slime/slime_textbox.visible = true
			#$Slime/slime_textbox/CanvasLayer/SlimeLabel.visible = true
			#$Girl/girl_textbox.visible = true
			#$Girl/girl_textbox/CanvasLayer/GirlLabel.visible = true
		#if slimetextbox < slimearray.size():
			#$Slime/slime_textbox/CanvasLayer/SlimeLabel.text = slimearray[slimetextbox]
		#else:
			#$Slime/slime_textbox.visible = false
			#$Slime/slime_textbox/CanvasLayer/SlimeLabel.visible = false
			#slimetextbox = -1

		#if girltextbox < girlarray.size():
			#$Girl/girl_textbox/CanvasLayer/GirlLabel.text = girlarray[girltextbox]
		#else:
			#$Girl/girl_textbox.visible = false
			#$Girl/girl_textbox/CanvasLayer/GirlLabel.visible = false
			#girltextbox = -1

	if slimetextbox == 0:
		slimetextx = -85
		slimetexty = -43
	elif slimetextbox == 2 or slimetextbox == 6:
		slimetexty = -33
	elif slimetextbox == 3:
		slimetextx = -43
		slimetexty = -33
	else:
		slimetextx = -105
		slimetexty = -43

	if girltextbox == 0:
		girltextx = -105
	elif girltextbox == 1:
		girltextx = -145
	elif girltextbox == 2:
		girltextx = -145
	else:
		girltextx = -135

	$Slime/slime_textbox/CanvasLayer/SlimeLabel.global_position.x = $Slime/slime_textbox.global_position.x + slimetextx
	$Slime/slime_textbox/CanvasLayer/SlimeLabel.global_position.y = $Slime/slime_textbox.global_position.y + slimetexty
	$Girl/girl_textbox/CanvasLayer/GirlLabel.global_position.x = $Girl/girl_textbox.global_position.x + girltextx 
	$Girl/girl_textbox/CanvasLayer/GirlLabel.global_position.y = $Girl/girl_textbox.global_position.y + girltexty

	#var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") # tutorial movement code
	#velocity = input_direction * max_speed
	#move_and_slide()

	if global_position.x < 0: # walking to the left to change level
		if level == 1: # from hw 3 to 2
			level_changing(3, "r")
		elif level == 3: # from hw 2 to 1
			level_changing(4, "r")
		elif level == 2:
			level_changing(4, "rd")
		elif level == 7:
			level_changing(3, "rd")
		elif level == 9:
			level_changing(1, "rd")
		else:
			global_position.x = 0
	if global_position.x > 1150: # walking to the right to change level
		if level == 3: # from hw 2 to 3
			level_changing(1, "l")
		elif level == 4: # from hw 1 to 2
			level_changing(3, "l")
		#elif level == 5:
			#level_changing(4, "ld")
		elif level == 6:
			level_changing(3, "ld")
		elif level == 8:
			level_changing(1, "ld")
		else:
			global_position.x = 1150

	if Input.is_action_just_pressed("ui_up"): # action
		if left_door_action == true: # left door action
			if level == 1:
				level_changing(8, "r")
			if level == 3: 
				if haskey == true:
					haskey = false
					room_access = true
				level_changing(6, "r")# rm 102
				girl_anim.emit()
			#if level == 4:
				#level_changing(5, "r")
		if right_door_action == true: # right door action
			if level == 1:
				level_changing(9, "l")
			if level == 3:
				level_changing(7, "l")
			if level == 4:
				level_changing(2, "l")
		if vent_action == true:
			vent_cutscene = true
			anti_door_prompt.emit()
			conversation = 0
			$Slime.visible = false
		if bear_action == true:
			anti_door_prompt.emit()
			conversation = 0
			hasbear = true
			pickup_bear.emit()

	#var y_dir = Input.get_axis("ui_up", "ui_down")
	if start == true:
		if vent_cutscene == false and bear_cutscene == false:
			x_dir = Input.get_axis("ui_left", "ui_right")
		elif vent_cutscene == true: # vent cutscene
			x_dir = 0
			vent_timer += 1
			if vent_timer == 240:
				$Slime.animation = "key_walk"
				$Slime.visible = true
				#$Slime/heldkey.visible = true
				haskey = true
				conversation = 4
			if vent_timer == 280:
				vent_timer = 0
				vent_cutscene = false
				vent_complete = true

	if x_dir > 0: # flipping and slime move delay
		$Girl.flip_h = false
		$Slime.flip_h = false
		#$Slime/heldkey.flip_h = true
		if $Slime.position.x > -slime_dist: # I LOVE THIS CODE!!!!!!! its so cute
			$Slime.position.x -= slime_rotate_speed
	if x_dir < 0:
		$Girl.flip_h = true
		$Slime.flip_h = true
		#$Slime/heldkey.flip_h = false
		if $Slime.position.x < slime_dist: # love this!
			$Slime.position.x += slime_rotate_speed

	if x_vel == 0: #animation
		$Slime.stop()
		if haskey == true:
			$Slime.animation = "key_idle"
		elif hasbear == true:
			$Slime.animation = "bear_idle"
		else:
			$Slime.animation = "slime walk"
		$Girl.stop()
	else:
		$Slime.play()
		if haskey == true:
			$Slime.animation = "key_walk"
		elif hasbear == true:
			$Slime.animation = "bear_walk"
		else:
			$Slime.animation = "slime walk"
		$Girl.play()

	x_vel = speedness(x_dir, x_vel)
	velocity = transform.x * x_vel

	#print("x_dir:" + str(x_dir))
	#print("y_dir:" + str(y_dir))
	#y_vel = speedness(y_dir, y_vel)
	#print("x_vel:" + str(x_vel))
	#print("y_vel:" + str(y_vel))
	# + transform.y * y_vel
	move_and_slide()

func _on_player_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("doors") and (level == 1 or level == 3 or level == 4):
		if area.is_in_group("leftdoor") and level == 3 and haskey == true and room_access == false:
			conversation = 5
			left_door_action = true
			door_prompt.emit()
		elif area.is_in_group("leftdoor") and (not level == 4) and ((not level == 3) or (level == 3 and room_access == true)): #cus room 5 is unused and you need a key for room 102
			left_door_action = true
			door_prompt.emit()
		elif area.is_in_group("rightdoor"):
			right_door_action = true
			door_prompt.emit()
	if area.is_in_group("bg9_tube") and level == 9:
		conversation = 1
	if area.is_in_group("monster") and level == 7 and vent_complete == false:
		conversation = 2
	if area.is_in_group("vent") and level == 7 and vent_complete == false:
		conversation = 3
		vent_action = true
		door_prompt.emit()
	if area.is_in_group("crying girl") and level == 6 and hasbear == false:
		crying_girl_action = true
		conversation = 6
		door_prompt.emit()
	if area.is_in_group("bear") and level == 2 and crying_quest == true and hasbear == false:
		door_prompt.emit()
		conversation = 7
		bear_action = true
	if area.is_in_group("crying girl") and level == 6 and hasbear == true:
		give_bear_action = true
		conversation = 8
		door_prompt.emit()
	

func _on_player_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("doors") and (level == 1 or level == 3 or level == 4):
		if area.is_in_group("leftdoor") and not level == 4 : #cus room 5 is unused
			left_door_action = false
			anti_door_prompt.emit()
		elif area.is_in_group("rightdoor"):
			right_door_action = false
			anti_door_prompt.emit()
	if (area.is_in_group("bg9_tube") and level == 9) or (area.is_in_group("monster") and level == 7) or (area.is_in_group("vent") and level == 7) or (area.is_in_group("leftdoor") and level == 3) or (area.is_in_group("crying girl") and level == 6) or ((area.is_in_group("bear") and level == 2 and crying_quest == true)):
		conversation = 0
		vent_action = false
		crying_girl_action = false
		crying_convo = 0
		anti_door_prompt.emit()
		bear_action = false

#func  bg2() -> void:
	#level = 2
	#global_position.x = 25
	#global_position.y = 450
