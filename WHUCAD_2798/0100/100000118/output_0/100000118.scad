
// Parameters
base_size = 40;         // Outer width and depth of the square base
wall_thickness = 2;     // Thickness of the walls
base_height = 15;       // Height of the square base shell
ramp_height = base_height; // Height of the ramp (same as shell height)

// Module: Square Base Shell
module square_base_shell() {
    difference() {
        // Outer box
        cube([base_size, base_size, base_height], center = false);
        // Inner hollow
        translate([wall_thickness, wall_thickness, 0])
            cube([base_size - 2*wall_thickness, base_size - 2*wall_thickness, base_height], center = false);
    }
}

// Module: Internal Triangular Ramp
module internal_triangular_ramp() {
    // Create a right triangular prism using linear_extrude
    translate([wall_thickness, wall_thickness, 0])
        linear_extrude(height = base_size - 2*wall_thickness)
            polygon(points=[[0,0], [base_size - 2*wall_thickness, 0], [0, ramp_height]]);
}

// Assemble the model
union() {
    square_base_shell();
    internal_triangular_ramp();
}

