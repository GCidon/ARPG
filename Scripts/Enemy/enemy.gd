class_name EnemyCharacter extends AttackCharacter
	
func _ready():
	super._ready()
	
func setup():
	detection_area.body_entered.connect(_on_detection_area_body_entered)
	detection_area.body_exited.connect(_on_detection_area_body_exited)

func _on_detection_area_body_entered(body):
	if !(body is PlayerCharacter):
		return
	super._on_detection_area_body_entered(body)

func _on_detection_area_body_exited(body):
	if !(body is PlayerCharacter):
		return
	super._on_detection_area_body_exited(body)
