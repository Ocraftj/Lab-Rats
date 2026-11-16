extends Area2D

var text = ""

func _on_player_girl_anim() -> void:
	$crying_girl.play()

func _on_player_crying_text(num: Variant) -> void:
	if num == 0:
		$crying_girl/crying_textbox.visible = false
		$crying_girl/crying_textbox/CanvasLayer/Label.visible = false
	else:
		$crying_girl/crying_textbox.visible = true
		$crying_girl/crying_textbox/CanvasLayer/Label.visible = true
	if num == 1:
		text = "Mr. Lattice took my bear!\nHe took it! He took it!"
	if num == 2:
		text = "It’s not fair!"
	if num == 3:
		text = "He said I can’t have\nit back until I’m 'fixed'."
	if num == 4:
		text = "gubble! you found him!"
	if num == 5:
		text = "     thank you so so\n     so so so much!"
	$crying_girl/crying_textbox/CanvasLayer/Label.text = text

func _on_player_win() -> void:
	$crying_girl/crying_textbox/CanvasLayer/Label.visible = false
