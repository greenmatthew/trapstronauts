extends Node2D
export (int) var follow_speed = 50
var player = null

func _ready():
    $AnimationPlayer.play("Spin")
    
func _process(delta):
    $Path2D/PathFollow2D.offset += follow_speed * delta
    
func _on_Area2D_body_entered(body):
    if body is PlayerController:
        var _touched_player = get_tree().reload_current_scene()
        print('Player got sliced')
