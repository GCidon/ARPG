class_name CameraMount
extends Node3D

@onready var camera : Camera3D = $CameraPOV

func _process(delta):	
		camera_movement(delta)
	
func camera_movement(delta):
	if Input.is_action_pressed("cameraleft"):
		rotation.y += 1.0*delta
	if Input.is_action_pressed("cameraright"):
		rotation.y -= 1.0*delta
	if Input.is_action_pressed("cameraup"):
		if rotation.x < 0:
			rotation.x += 0.5*delta
		else:
			rotation.x = 0
	if Input.is_action_pressed("cameradown"):
		if rotation.x > -0.5:
			rotation.x -= 0.5*delta
		else:
			rotation.x = -0.5
