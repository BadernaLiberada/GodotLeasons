extends Node
var playerRef: Player
var gameTime:=0.0
var latinha := false

var textLabel:RichTextLabel
var textSpeed:=2.0

func _process(delta: float) -> void:
	gameTime+=delta
	if textLabel!=null:
		textLabel.visible_ratio += delta*textSpeed

func _updateText(text:String) -> void:
	if textLabel:
		textLabel.text = text
		textLabel.visible_ratio=0
