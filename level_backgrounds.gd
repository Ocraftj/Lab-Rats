extends Node

func level_set(num):
	if num == 1:
		$bg1_hw3.visible = true
		$CanvasLayer/room.text = "bg1_hw3"
		#$bg1_hw3/bg1_door_hitbox.visible = true
	else:
		$bg1_hw3.visible = false
		#$bg1_hw3/bg1_door_hitbox.visible = false
	
	if num == 2:
		$bg2_rm101.visible = true
		$CanvasLayer/room.text = "bg2_rm101"
	else:
		$bg2_rm101.visible = false
	
	if num == 3:
		$bg3_hw2.visible = true
		$CanvasLayer/room.text = "bg3_hw2"
	else:
		$bg3_hw2.visible = false
	
	if num == 4:
		$bg4_hw1.visible = true
		$CanvasLayer/room.text = "bg4_hw1"
	else:
		$bg4_hw1.visible = false
	
	#if num == 5:
		#$bg5_rm100.visible = true
		#$CanvasLayer/room.text = "bg5_rm100"
	#else:
		#$bg5_rm100.visible = false
	
	if num == 6:
		$bg6_rm102.visible = true
		$CanvasLayer/room.text = "bg6_rm102"
	else:
		$bg6_rm102.visible = false
	
	if num == 7:
		$bg7_rm103.visible = true
		$CanvasLayer/room.text = "bg7_rm103"
	else:
		$bg7_rm103.visible = false
	
	if num == 8:
		$bg8_rm104.visible = true
		$CanvasLayer/room.text = "bg8_rm104"
	else:
		$bg8_rm104.visible = false
	
	if num == 9:
		$bg9_rm105.visible = true
		$CanvasLayer/room.text = "bg9_rm105"
	else:
		$bg9_rm105.visible = false

func _on_player_level_change(num: Variant) -> void:
	level_set(num)
	$CanvasLayer/door_prompt.visible = false

func _on_player_door_prompt() -> void:
	$CanvasLayer/door_prompt.visible = true
	$CanvasLayer/door_prompt.play()
	$bg7_rm103/monsterarea/monster.play()

func _on_player_anti_door_prompt() -> void:
	$CanvasLayer/door_prompt.visible = false

func _on_player_pickup_bear() -> void:
	$"bg2_rm101/teddy bear".visible = false

func _on_player_give_bear() -> void:
	$bg6_rm102/crying_girl_area/crying_girl.animation = "happy"

func _on_player_win() -> void:
	$win.visible = true
	$win/hallway_song.stop()
	$win/win_song.play()
