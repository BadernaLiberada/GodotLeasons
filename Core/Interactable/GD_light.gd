extends InteractableItem
var lightOn=false

func _interact()->void:
	if canInteract:
		lightOn = not lightOn
		if lightOn:	$MeshNode/MeshInstance3D.get_surface_override_material(0).emission_energy_multiplier = 5
		else:	$MeshNode/MeshInstance3D.get_surface_override_material(0).emission_energy_multiplier = 0
