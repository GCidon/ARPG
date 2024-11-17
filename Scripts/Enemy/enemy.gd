class_name EnemyCharacter extends Character

func _ready():
	detection_area.body_entered.connect(_on_detection_area_body_entered)
	detection_area.body_exited.connect(_on_detection_area_body_exited)

func _on_detection_area_body_entered(body):
	if body is PlayerCharacter:
		super.detection_enter(body)

func _on_detection_area_body_exited(body):
	if body is PlayerCharacter:
		super.detection_exit(body)
