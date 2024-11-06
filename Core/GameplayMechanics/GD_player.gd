class_name Player
extends CharacterBody3D
#region
@export_group("Physics")
@export var moveSpeed := 8.0
@export var acceleration := 8.0
@export var jumpInitialImpulse := 12.0
@export var gravity: float = 30.0
# Input Variables
@onready var movementInput : Vector2
@onready var movement_velocity: Vector3
@onready var is_zooming := false
#@onready var can_double_jump := true
@onready var is_just_jumping := false
@onready var is_just_on_floor := false






@export_group("Camera")
enum CAMERA_STATE { DEFAULTPOS,NOCAMERACONTROL, CUTSCENE}
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25
@export_range(0.0, 8.0) var joystick_sensitivity := 2.0
@export var cameraRotSpeed := 25.0
@export var headMoveAmount :=1.0
@export var cameraHeadMoveSpeed :=1.0
@export var cameraZoomSpeed := 10.0
@onready var defaultPivot: Node3D = $CameraSystem/DefaultPivot
@onready var playerCamera: Camera3D = $CameraSystem/SpringArm3D/Camera3D
@onready var _camera_spring_arm:= $CameraSystem/SpringArm3D
@onready var rayCastInteract:= $CameraSystem/SpringArm3D/Camera3D/RayCastInteract
var defaultPivotPosition:Vector3
var camera_state: CAMERA_STATE
var mouseInput : Vector2
@onready var can_double_jump := true
@onready var rotation_target := Vector3.ZERO
#endregion

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	defaultPivotPosition = defaultPivot.position

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		mouseInput.x = -event.relative.x * mouse_sensitivity
		mouseInput.y = -event.relative.y * mouse_sensitivity
		rotation_target.x += mouseInput.x
		rotation_target.y = clampf(rotation_target.y + mouseInput.y, -90.0,90.0)

func _getInput()->void:
	is_just_jumping = Input.is_action_just_pressed("jump")
	is_zooming = Input.is_action_pressed("zoom")
	is_just_on_floor = is_on_floor()
	movementInput = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if Input.is_action_just_pressed("interact"):
		_interact()

func _physics_process(delta: float) -> void:
	_getInput()
	_camera_movement(delta)
	_movement(delta)

func _camera_movement(delta:float)->void:
	rotation.y = lerp_angle(rotation.y, deg_to_rad(rotation_target.x), delta*cameraRotSpeed)
	playerCamera.rotation.x = lerp_angle(playerCamera.rotation.x, deg_to_rad(rotation_target.y), delta * cameraRotSpeed)
	if movementInput.length()>0:
		var headpos = defaultPivotPosition.y + sin(GameInstance.gameTime*cameraHeadMoveSpeed) * headMoveAmount
		defaultPivot.position.y = lerp(defaultPivot.position.y,headpos,delta*15)
	else:
		defaultPivot.position.y = lerp(defaultPivot.position.y,defaultPivotPosition.y,delta*5)
	
	if camera_state == CAMERA_STATE.DEFAULTPOS:
		_camera_spring_arm.global_position = defaultPivot.global_position
	
	if is_zooming:
		playerCamera.fov=lerp(playerCamera.fov,30.0,delta*cameraZoomSpeed)
	else:
		playerCamera.fov=lerp(playerCamera.fov,75.0,delta*cameraZoomSpeed)

func _movement(delta:float) -> void:
	if not is_on_floor(): velocity.y -= gravity * delta
	var verticalVelocity = velocity.y
	velocity.y = 0.0
	var moveDirection = transform.basis * Vector3(movementInput.x,0,movementInput.y)
	
	velocity = velocity.lerp(moveDirection * moveSpeed, acceleration * delta)
	if is_just_jumping and is_on_floor(): verticalVelocity = jumpInitialImpulse
	velocity.y = verticalVelocity
	move_and_slide()

func _interact() -> void:
	pass
