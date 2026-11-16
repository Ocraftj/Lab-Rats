extends Sprite2D

var textbox = -1
var slimearray = [
	"hello im slime", # same as what the label starts as
	"sup im slime",
	"hi im slime",
	"yo im slime",
	"wazzup im slime"
	]

func _on_player_text_1() -> void:
	textbox += 1
	
	if textbox == 0:
		visible = true
		$CanvasLayer/SlimeLabel.visible = true
	elif textbox < array.size():
		$CanvasLayer/SlimeLabel.text = slimearray[textbox]
	else:
		visible = false
		$CanvasLayer/SlimeLabel.visible = false
		textbox = -1
