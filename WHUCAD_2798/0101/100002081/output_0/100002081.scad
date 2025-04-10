
// Parameters
block_width = 40;
block_depth = 40;
block_height = 30;

pyramid_base = 15;
pyramid_height = 10;
pyramid_spacing = 5;

// Module to create a square pyramid
module square_pyramid(base, height) {
    polyhedron(
        points=[
            [0, 0, 0],                // base corner 1
            [base, 0, 0],             // base corner 2
            [base, base, 0],          // base corner 3
            [0, base, 0],             // base corner 4
            [base/2, base/2, height]  // apex
        ],
        faces=[
            [0, 1, 4],
            [1, 2, 4],
            [2, 3, 4],
            [3, 0, 4],
            [0, 1, 2, 3]
        ]
    );
}

// Main block with pyramidal recesses
difference() {
    // Solid block
    cube([block_width, block_depth, block_height]);

    // Pyramidal recesses
    for (x = [0, 1])
        for (y = [0, 1])
            translate([
                x * (pyramid_base + pyramid_spacing) + pyramid_spacing,
                y * (pyramid_base + pyramid_spacing) + pyramid_spacing,
                block_height - 0.01  // Slight offset to ensure clean subtraction
            ])
            rotate([0, 0, 0])
            mirror([0, 0, 1])  // Invert pyramid to make it a recess
            square_pyramid(pyramid_base, pyramid_height);
}

