class_name AttackCharacter extends DetectableCharacter

var attack_timer : Timer = null

var attack_area : Area3D = null

var readyToAttack : bool = false
var onRangeToAttack : bool = false

func _ready():
	super._ready()
	attack_area = Area3D.new()
	attack_area.name = "AttackArea"
	var shape = CollisionShape3D.new()
	var sphere : SphereShape3D = SphereShape3D.new()
	sphere.radius = 1
	shape.shape = sphere
	attack_area.add_child(shape)
	add_child(attack_area)
	attack_area.body_entered.connect(_on_attack_area_body_entered)
	attack_area.body_exited.connect(_on_attack_area_body_exited)
	
	attack_timer = Timer.new()
	add_child(attack_timer)
	attack_timer.wait_time = 2
	attack_timer.timeout.connect(attack_base)
	
func _process(delta):
	super._process(delta)
	if onRangeToAttack and readyToAttack:
		if body_detected == null:
			onRangeToAttack = false
			return
		make_attack()
		readyToAttack = false
		attack_timer.start()
		
func make_attack():
	var char : Character = body_detected as Character
	char.take_phys_damage(attack)
	
func attack_base():
	readyToAttack = true
	attack_timer.stop()
	
func detect():
	attack_timer.start()
	
func _on_attack_area_body_entered(body):
	if body == body_detected:
		onRangeToAttack = true
		
func _on_attack_area_body_exited(body):
	if body == body_detected:
		onRangeToAttack = false
