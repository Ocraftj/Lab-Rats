extends Sprite2D

var textbox = -1
var array = [
	"sup",
	"hi",
	"yo",
	"wazzup"
	]

func _on_player_text_1() -> void:
	textbox += 1
	
	if textbox == 0:
		visible = true
		$CanvasLayer/GirlLabel.visible = true
	elif textbox < array.size()+1:
		$CanvasLayer/GirlLabel.text = array[textbox-1]
	else:
		visible = false
		$CanvasLayer/GirlLabel.visible = false
		textbox = -1
