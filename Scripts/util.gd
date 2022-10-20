
static func pos_clamped_to_grid(position: Vector2, grid_block_size: int) -> Vector2:
    var desired_x = find_closest_divisible_by(int(position.x), grid_block_size);
    var desired_y = find_closest_divisible_by(int(position.y), grid_block_size);

    return Vector2(desired_x, desired_y)

## Find number closest to n which is divisible by m
## Only works for postive numbers
## https://www.tutorialspoint.com/find-the-number-closest-to-n-and-divisible-by-m-in-cplusplus
static func find_closest_divisible_by(n: int, m: int) -> int:
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

static func get_all_children(node: Node) -> Array:
    var nodes: Array = []

    for n in node.get_children():
        if n.get_child_count() > 0:
            nodes.append(n)
            nodes.append_array(get_all_children(n))
        else:
            nodes.append(n)

    return nodes
