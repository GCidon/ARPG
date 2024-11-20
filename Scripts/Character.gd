class_name Character extends CharacterBody3D

var hp : int = 5
var mp : int = 10
var attack : int = 10
var mattack : int = 4
var armor : int = 5
var mres : int = 4
var speed : int = 5

var dmg_timer : Timer
var prev_color : Color

@onready var hp_loss : HpLossText = $HpLossText as HpLossText

@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D

func _ready():
	dmg_timer = Timer.new()
	add_child(dmg_timer)
	dmg_timer.wait_time = 0.2
	dmg_timer.timeout.connect(quitarse_red)
	
func _physics_process(delta):
	var destination = nav_agent.get_next_path_position()
	var local_dest = destination - global_position
	var dest = local_dest.normalized()
	
	velocity = dest * 5.0
	move_and_slide()

func take_phys_damage(dmg):
	var real_dmg = dmg * (100/(100+armor))
	take_real_dmg(real_dmg)
	
func take_mag_damage(dmg):
	var real_dmg = dmg * (100/(100+mres))
	take_real_dmg(real_dmg)
		
func take_real_dmg(dmg):
	if dmg < 1:
		dmg = 1
	hp -= dmg
	if hp <= 0:
		hp = 0
		die()
	else:
		ponerse_red()
		dmg_timer.start()
		hp_loss.change_num(dmg)

func die():
	queue_free()
	
func ponerse_red():
	var meshinst = $MeshInstance3D as MeshInstance3D
	var cill = meshinst.mesh as CapsuleMesh
	var mat = cill.material as StandardMaterial3D
	prev_color = mat.albedo_color
	mat.albedo_color = Color.RED
	
func quitarse_red():
	var meshinst = $MeshInstance3D as MeshInstance3D
	var cill = meshinst.mesh as CapsuleMesh
	var mat = cill.material as StandardMaterial3D
	mat.albedo_color = prev_color
	dmg_timer.stop()
	
func go_to(newpos):
	nav_agent.target_position = newpos
