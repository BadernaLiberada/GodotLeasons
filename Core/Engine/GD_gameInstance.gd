extends Node
var playerRef: Player
var gameTime:=0.0

func _process(delta: float) -> void:
	gameTime+=delta

func _set_player_reference(_playerRef:Player) ->void:
	playerRef = _playerRef
