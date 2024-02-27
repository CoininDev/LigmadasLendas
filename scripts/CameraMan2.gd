extends Node3D

@onready var camera = $Elevation/Camera3D

#########################
## PARAMS
#########################
#move
@export var speed = 10
@export var corner_margin = 20
#zoom
@export var min_zoom_out = 2
@export var max_zoom_out = 90
@export var zoom_speed = 10
#rotation
@export var min_angle = 10
@export var max_angle = 75
@export var rotation_speed = 0.2
#lock_in_object
@export var point:HeroBase
@export var smoth_speed = 15
var lock_cam:bool = true
var lock_cam_persist:bool



#HUD Properties
@onready var timeout_q:Label = $CanvasLayer/Control/H/Abilites/Q/TimeOutLabel
@onready var timeout_w:Label = $CanvasLayer/Control/H/Abilites/W/TimeOutLabel
@onready var timeout_e:Label = $CanvasLayer/Control/H/Abilites/E/TimeOutLabel
@onready var timeout_r:Label = $CanvasLayer/Control/H/Abilites/R/TimeOutLabel

@onready var level_q:Label = $CanvasLayer/Control/H/Abilites/Q/LevelLabel
@onready var level_w:Label = $CanvasLayer/Control/H/Abilites/W/LevelLabel
@onready var level_e:Label = $CanvasLayer/Control/H/Abilites/E/LevelLabel
@onready var level_r:Label = $CanvasLayer/Control/H/Abilites/R/LevelLabel

@onready var nivel:Label = $"CanvasLayer/Control/H/stats/nível"
@onready var xp:Label = $CanvasLayer/Control/H/stats/xp
@onready var ouro:Label = $CanvasLayer/Control/H/stats/ouro
@onready var ap:Label = $CanvasLayer/Control/H/stats/AP

@onready var fps_label:Label = $CanvasLayer/Control/VBoxContainer/FPSLabel
@onready var respawn_time_label:Label = $CanvasLayer/Control/VBoxContainer/RespawnTimeLabel

func _process(delta):
    HUD()
    left_top_HUD()
    if lock_cam:
        var tween:Tween = create_tween()
        #global_position = lerp(global_position, point.global_position, smoth_speed * delta)
        tween.tween_property(self, "global_position", point.global_position, 0.5)
        #global_position = point.global_position
        return
    move(delta)
    

func _input(event):
    zoom()
    rotate_camera(event)
    lock_cam = Input.is_action_pressed("space") or lock_cam_persist
    if Input.is_action_just_pressed("lock_camera"):
        lock_cam_persist = !lock_cam_persist

func move(delta:float):
    var v_size = get_viewport().size
    var dir = Vector3()
    var m_pos = get_viewport().get_mouse_position()
    if m_pos.x < corner_margin:
        dir.x -= 1
    if m_pos.x > v_size.x - corner_margin:
        dir.x += 1
    if m_pos.y < corner_margin:
        dir.z -= 1
    if m_pos.y > v_size.y - corner_margin:
        dir.z += 1
    #var dir:Vector3  = Vector3(Input.get_axis("ui_left","ui_right"), 0, Input.get_axis("ui_up", "ui_down")).normalized()
    position += dir.normalized() * delta * speed 

func zoom():
    #zoom in
    if Input.is_action_pressed("scroll_up"):
        if camera.position.z > min_zoom_out:
            camera.position.z -= 1
            speed -= 1
    
    #zoom out
    if Input.is_action_pressed("scroll_down"):
        if camera.position.z < max_zoom_out:
            camera.position.z += 1
            speed += 1

func rotate_camera(event:InputEvent):
    if Input.is_action_pressed("rotate_camera"):
        if event is InputEventMouseMotion:
            $Elevation.rotation_degrees.x -= event.relative.y * rotation_speed
            $Elevation.rotation_degrees.x = clamp($Elevation.rotation_degrees.x, -max_angle, -min_angle)
            Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
            #rotation_degrees.y -= event.relative.x * rotation_speed
    else:
        Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func HUD():
    #timeouts
    timeout_q.text = "%2d" % point.q_cooldown.time_left
    timeout_w.text = "%2d" % point.w_cooldown.time_left
    timeout_e.text = "%2d" % point.e_cooldown.time_left
    timeout_r.text = "%2d" % point.r_cooldown.time_left
    if point.q_cooldown.time_left == 0: timeout_q.text = ""
    if point.w_cooldown.time_left == 0: timeout_w.text = ""
    if point.e_cooldown.time_left == 0: timeout_e.text = ""
    if point.r_cooldown.time_left == 0: timeout_r.text = ""
    
    nivel.text ="Nível: "+ str(point.xp_comp.level)
    xp.text ="XP: "+ str(point.xp_comp.current_xp)
    ouro.text = "Ouro:"+str(point.gold)
    ap.text = "AP: "+str(point.ability_power)
    
    level_q.text = str(point.xp_comp.ability1_lvl)
    level_w.text = str(point.xp_comp.ability2_lvl)
    level_e.text = str(point.xp_comp.ability3_lvl)
    level_r.text = str(point.xp_comp.ultimate_lvl)

func left_top_HUD():
    fps_label.text = "FPS: " + str(Engine.get_frames_per_second())
    if point.state_machine_comp.current_state is HeroDeadState:
        respawn_time_label.visible = true
        respawn_time_label.text = "Respawn in %d" % point.state_machine_comp.current_state.death_time_count
    else:
        respawn_time_label.visible = false
