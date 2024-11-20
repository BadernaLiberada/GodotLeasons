@tool
class_name MainLayer
extends SkeletonModifier3D
@export_enum(" ") var bonehead: String
@export_enum(" ") var boneeye: String
@export var target_coordinate:Marker3D

func _validate_property(property: Dictionary) -> void:
	if property.name == "bonehead" or property.name == "boneeye":
		var skeleton: Skeleton3D = get_skeleton()
		if skeleton:
			property.hint = PROPERTY_HINT_ENUM
			property.hint_string = skeleton.get_concatenated_bone_names()


func _process_modification() -> void:
	#skeleton
	#bone
	#pose - Transform3D
	var skeleton = get_skeleton()
	if skeleton!=null:
		dalek_look_system(skeleton,bonehead,true)
		dalek_look_system(skeleton,boneeye,false)
	

func dalek_look_system(skeleton:Skeleton3D,bone:String,ignoreY:bool): #boneindex, pose - transform3D
	var bone_idx: int = skeleton.find_bone(bone)
	var pose :Transform3D = skeleton.global_transform * skeleton.get_bone_global_pose(bone_idx)
	var lookposition = target_coordinate.global_position
	if(ignoreY):
		lookposition.y = pose.origin.y
	pose = pose.looking_at(lookposition,Vector3.UP,true)
	# basis quaternion <----
	# origin posições default
	
	pose = Transform3D(pose.basis, skeleton.get_bone_global_pose(bone_idx).origin)
	skeleton.set_bone_global_pose(bone_idx, pose)
