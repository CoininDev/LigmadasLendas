extends Node3D
class_name Cast
signal removed
@export var atk: Attack
@export var gfx:Mesh

func remove_self():
    print(atk)
    #if atk.caster.has_method("removed_cast"):
    #    removed.connect(atk.caster.removed_cast)
    #removed.emit(self)
    queue_free()
