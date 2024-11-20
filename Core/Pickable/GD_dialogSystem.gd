extends InteractableItem

@export var text:PackedStringArray
var currentTextIndex:=0
var looking :=false
@onready var lookMarker:=$Dalek/skel/Skeleton3D/MainLayer/Marker3D
@onready var mainLayerAnimation:=$Dalek/skel/Skeleton3D/MainLayer
func _interact()->void:
	if canInteract:
		if text.size()>currentTextIndex:
			print("have text")
			var appendtext = "[center][shake rate=20.0 level=5 connected=1]"+text[currentTextIndex]
			GameInstance._updateText(appendtext)
			currentTextIndex+=1
			if currentTextIndex>text.size():
				currentTextIndex=0

func _physics_process(delta: float) -> void:
	var lookValue = 0.0
	if GameInstance.playerRef!=null and looking:
		lookMarker.global_position = GameInstance.playerRef.playerCamera.global_position
		lookValue=.7
	
	mainLayerAnimation.influence = lerp(mainLayerAnimation.influence,lookValue,delta*4)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body==GameInstance.playerRef:
		looking=true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body==GameInstance.playerRef:
		looking=false
