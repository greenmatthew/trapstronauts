extends Area2D

export var grid_block_size : int
var dragging = false


func _input_event(_viewport, event, _shape_idx):
    if event is InputEventMouseButton and event.is_pressed():
        dragging = true

func _unhandled_input(event):
    if event is InputEventMouseButton and not event.is_pressed():
        dragging = false
    if dragging and event is InputEventMouseMotion:
        var cursor_position = event.position

        var desired_x = find_closest_divisible_by(cursor_position.x, grid_block_size);
        var desired_y = find_closest_divisible_by(cursor_position.y, grid_block_size);

        self.position = Vector2(desired_x, desired_y)

func clamp_pos_to_grid():
    var desired_x = floor(position.x / grid_block_size) * grid_block_size 

    var desired_y = floor(position.y / grid_block_size) * grid_block_size 

    self.position = Vector2(desired_x, desired_y)

## Find number closest to n which is divisible by m
##
## https://www.tutorialspoint.com/find-the-number-closest-to-n-and-divisible-by-m-in-cplusplus
func find_closest_divisible_by(n: int, m: int) -> int:
    # warning-ignore:integer_division
    var q = n / m
    var n1 = m * q

    var n2
    if (n * m) > 0:
        n2 = m * (q + 1)
    else:
        n2 = m * (q - 1)

    if abs(n - n1) < abs(n - n2):
        return n1

    return n2
