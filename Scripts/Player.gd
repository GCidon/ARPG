class_name PlayerCharacter extends AttackCharacter

@export var SPEED = 5.0

@onready var mount : CameraMount = $Mount

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var controlled_movement : bool = false

func _ready():
	super._ready()
	
func setup():
	detection_area.body_entered.connect(_on_detection_area_body_entered)
	detection_area.body_exited.connect(_on_detection_area_body_exited)
	var shape = detection_area.get_child(0) as CollisionShape3D
	var sphere : SphereShape3D = shape.shape as SphereShape3D
	sphere.radius = 8
	line_color = Color.BLUE

func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3.UP, mount.rotation.y).normalized()
	
	controlled_movement = (input_dir != Vector2.ZERO)
	
	if !controlled_movement:
		super._physics_process(delta)
		return
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	velocity.y = -gravity

	move_and_slide()

func _on_detection_area_body_entered(body):
	if !(body is EnemyCharacter):
		return
	chase()
	super._on_detection_area_body_entered(body)

func _on_detection_area_body_exited(body):
	if !(body is EnemyCharacter):
		return
	stop_chase()
	super._on_detection_area_body_exited(body)
