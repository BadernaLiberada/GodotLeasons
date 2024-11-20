class_name InteractableItem
extends Area3D

var canInteract =false:
	set(value):
		canInteract = value
		$Label3D.visible=value
		if GameInstance.playerRef.interactableItemOBJ==self:
			GameInstance.playerRef.interactableItemOBJ=null

func _physics_process(delta: float) -> void:
	if GameInstance.playerRef.rayCastInteract.get_collider()!=self:
		canInteract = false

func _interact()->void:
	pass
