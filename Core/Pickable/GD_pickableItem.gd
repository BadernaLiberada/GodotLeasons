extends InteractableItem
@export var particleSystem: CPUParticles3D

func _on_timer_timeout() -> void:
	if particleSystem:
		particleSystem.emitting=true

func _interact()->void:
	if canInteract:
		get_parent().remove_child(self)
		GameInstance.playerRef.playerHandSlot.add_child(self)
		self.global_position = GameInstance.playerRef.playerHandSlot.global_position
		canInteract=false
