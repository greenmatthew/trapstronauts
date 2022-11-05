import sys
import png

# helper function that returns all command line args
def get_args(argc: int, argv: list):
    width = int(argv[1]) # First arg is the width per sprite
    height = int(argv[2]) # Second arg is the height per sprite
    filepath = argv[3] # Third arg is the file path
    output_dir = argv[4] # Fourth arg is the output directory

    return width, height, filepath, output_dir


# Returns whether a sprite is equal to another sprite
def is_equal(sprite1: list, sprite2: list):
    return sprite1 == sprite2


def main(argc: int, argv: list):
    sprite_width, sprite_height, src_filepath, output_dir = get_args(argc, argv)

    src = png.Reader(filename=src_filepath)
    src_width, src_height, pixels, src_info = src.read_flat()

    # print image resolution
    print(f"Source: {src_filepath}")
    print(f"Resolution: {src_width}x{src_height}")
    print(f"Sprite Resolution: {sprite_width}x{sprite_height}")

    rows = int(src_width / sprite_width)
    cols = int(src_height / sprite_height)

    print(f"Sprites: {rows * cols} (r: {rows}, c: {cols})")

    dims_per_color = 4 if src_info["alpha"] else 3

    # print(pixels)

    # Turn sprite sheet into a 2D array of sprites according to the sprite width and height
    row_offset = src_width * dims_per_color
    sprites = []
    for r in range(rows):
        sprites.append([])
        for c in range(cols):
            for y in range(sprite_height):
                to = r * row_offset + c * dims_per_color
                fromm = w * dims_per_color + sprite_width * dims_per_color + r * row_offset
                sprites[r][c].append(pixels[to:fromm])
                        
    
    print(sprites[0])

    
    # Save all sprites to the output directory
    for i in range(rows):
        for j in range(cols):
            # Create the output filename
            output_filename = f"{output_dir}/sprite_{i}_{j}.png"

            # Write the sprite to the output file
            with open(output_filename, "wb") as f:
                w = png.Writer(sprite_width, sprite_height, **src_info)
                w.write(f, sprites[i][j])

if __name__ == "__main__":
    main(len(sys.argv), sys.argv)
