class_name Character
extends CharacterBody3D

var detection_area : Area3D

var attack_line_mesh : MeshInstance3D
var immediate_mesh : ImmediateMesh
var material : ORMMaterial3D = ORMMaterial3D.new()

var body_detected : Node3D = null
var target_position : Vector3 = Vector3.ZERO

var line_color = Color.RED

func _ready():
	detection_area = Area3D.new()
	var shape = CollisionShape3D.new()
	var sphere : SphereShape3D = SphereShape3D.new()
	sphere.radius = 5
	shape.shape = sphere
	detection_area.add_child(shape)
	add_child(detection_area)
	setup()
	
func setup():
	pass

func _process(delta):
	if body_detected != null:
		target_position = body_detected.global_position
		immediate_mesh.clear_surfaces()
		immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
		immediate_mesh.surface_add_vertex(global_position)
		immediate_mesh.surface_add_vertex(target_position)
		immediate_mesh.surface_end()
		
func detection_enter(body):
	body_detected = body
	target_position = body_detected.global_position
		
	create_attack_line(target_position)
	
func detection_exit(body):
	body_detected = null
	target_position = Vector3.ZERO
			
	destroy_attack_line()	
		
func create_attack_line(target_position):
	attack_line_mesh = MeshInstance3D.new()
	immediate_mesh = ImmediateMesh.new()
	attack_line_mesh.mesh = immediate_mesh
	attack_line_mesh.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = line_color
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(global_position)
	immediate_mesh.surface_add_vertex(target_position)
	immediate_mesh.surface_end()
	return await final_cleanup(attack_line_mesh)
	
func destroy_attack_line():
	attack_line_mesh.queue_free()
	attack_line_mesh = null
	immediate_mesh = null
		
func final_cleanup(mesh_instance: MeshInstance3D):
	get_tree().get_root().add_child(mesh_instance)
	return mesh_instance

