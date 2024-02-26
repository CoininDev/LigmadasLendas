class_name NewPointer
extends Node3D

@export var pointer_range:float = 7
var mouse_pos:Vector3
var mouse_target:Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    var result = GeneralFuncs.mouse_raycast()
    var result_entity = GeneralFuncs.mouse_raycast_entity()
    if !result.is_empty():
        mouse_pos = result["position"]
    if !result_entity.is_empty():
        mouse_target = result_entity["collider"]
    
    ##positions
    look_at(mouse_pos)
    rotation.x = 0
    if $CircleSprite.position.z >= pointer_range && $CircleSprite.position.z <= 0: #frente = Z negativo
        $CircleSprite.position.z = -global_position.distance_to(mouse_pos)

func show_direction():
    $DirectionSprite.scale.z = pointer_range
    $DirectionSprite.position.z = -pointer_range/2
    $DirectionSprite.visible = true

func show_cone(spread:float):
    $ConeSprite.scale.z = pointer_range 
    $ConeSprite.scale.x = pointer_range * spread
    $ConeSprite.position.z = -pointer_range/2 
    $ConeSprite.visible = true

func show_range():
    $RangeSprite.scale = pointer_range*0.8
    $RangeSprite.visible = true

func show_circle(circle_radius:float):
    $CircleSprite.scale = circle_radius*0.8
    $CircleSprite.visible = true

func hide_all():
    $DirectionSprite.visible = false
    $ConeSprite.visible = false
    $CircleSprite.visible = false
    $RangeSprite.visible = false
