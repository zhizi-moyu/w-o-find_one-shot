
// Dimensions
base_width = 20;
base_depth = 30;
base_height = 10;

top_block_width = 20;
top_block_depth = 15;
top_block_height = 10;

sloped_length = 15;
sloped_height = 10;

// Base block
cube([base_width, base_depth, base_height]);

// Top block (stepped part)
translate([0, base_depth - top_block_depth, base_height])
    cube([top_block_width, top_block_depth, top_block_height]);

// Sloped block
translate([0, 0, 0])
    linear_extrude(height = base_width)
        polygon(points=[
            [0, 0],
            [sloped_length, 0],
            [sloped_length, sloped_height],
            [0, base_height]
        ]);

