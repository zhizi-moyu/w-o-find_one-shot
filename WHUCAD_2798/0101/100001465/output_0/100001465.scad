```scad
// Parameters
shell_height = 40;
shell_top_x = 30;
shell_top_y = 20;
shell_bottom_x = 26;
shell_bottom_y = 16;
wall_thickness = 2;
flange_thickness = 2;
flange_extension = 4;

// Outer tapered shell
module outer_rectangular_shell() {
    difference() {
        // Outer tapered shell
        hull() {
            translate([0, 0, 0])
                cube([shell_bottom_x, shell_bottom_y, shell_height], center = false);
            translate([-(shell_top_x - shell_bottom_x)/2, -(shell_top_y - shell_bottom_y)/2, shell_height])
                cube([shell_top_x, shell_top_y, 0.1], center = false);
        }
        // Inner hollow
        hull() {
            translate([wall_thickness, wall_thickness, 0])
                cube([shell_bottom_x - 2*wall_thickness, shell_bottom_y - 2*wall_thickness, shell_height], center = false);
            translate([-(shell_top_x - shell_bottom_x)/2 + wall_thickness, -(shell_top_y - shell_bottom_y)/2 + wall_thickness, shell_height])
                cube([shell_top_x - 2*wall_thickness, shell_top_y - 2*wall_thickness, 0.1], center = false);
        }
    }
}

// Top flange
module top_flange_frame() {
    difference() {
        translate([-(flange_extension), -(flange_extension), shell_height])
            cube([shell_top_x + 2*flange_extension, shell_top_y + 2*flange_extension, flange_thickness]);
        translate([0, 0, shell_height])
            cube([shell_top_x, shell_top_y, flange_thickness]);
    }
}

// Bottom flange
module bottom_flange_base() {
    difference() {
        translate([-(flange_extension), -(flange_extension), -flange_thickness])
            cube([shell_bottom_x + 2*flange_extension, shell_bottom_y + 2*flange_extension, flange_thickness]);
        // No cutout needed, it's a solid base
    }
}

// Inner slanted wall
module inner_slanted_wall_panel() {
    polyhedron(
        points=[
            [wall_thickness, wall_thickness, 0],  // bottom front-left
            [shell_bottom_x - wall_thickness, wall_thickness, 0],  // bottom front-right
            [shell_top_x - wall_thickness, shell_top_y - wall_thickness, shell_height],  // top back-right
            [wall_thickness, shell_top_y - wall_thickness, shell_height]  // top back-left
        ],
        faces=[
            [0, 1, 2, 3]
        ]
    );
}

// Assemble the model
module full_model() {
    outer_rectangular_shell();
    top_flange_frame();
    bottom_flange_base();
    inner_slanted_wall_panel();
}

full_model();
```

