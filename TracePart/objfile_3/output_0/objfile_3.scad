
// Parameters
coupling_diameter = 20;
coupling_length = 30;
bore_diameter = 8;
bore_depth = 15;
slit_width = 1;
slit_depth = 10;
screw_diameter = 5;
screw_head_diameter = 8;
screw_head_depth = 4;
hex_radius = 2.5;

// Main assembly
module flexible_coupling() {
    difference() {
        // Main cylindrical body
        cylinder(h = coupling_length, d = coupling_diameter, $fn=100);

        // Axial bores on both ends
        translate([0, 0, 0])
            cylinder(h = bore_depth, d = bore_diameter, $fn=100);
        translate([0, 0, coupling_length - bore_depth])
            cylinder(h = bore_depth, d = bore_diameter, $fn=100);

        // Slits on both ends
        translate([-slit_width/2, coupling_diameter/2 - 1, 0])
            cube([slit_width, 2, slit_depth]);
        translate([-slit_width/2, coupling_diameter/2 - 1, coupling_length - slit_depth])
            cube([slit_width, 2, slit_depth]);

        // Recessed hex holes for screws
        for (z = [5, coupling_length - 5]) {
            translate([coupling_diameter/2 - 1, 0, z])
                rotate([0, 90, 0])
                    hex_hole();
        }
    }

    // Screws
    for (z = [5, coupling_length - 5]) {
        translate([coupling_diameter/2 - 1, 0, z])
            rotate([0, 90, 0])
                screw();
    }
}

// Hexagonal hole for screw head
module hex_hole() {
    cylinder(h = screw_head_depth, r = hex_radius, $fn=6);
    translate([0, 0, screw_head_depth])
        cylinder(h = 10, d = screw_diameter, $fn=50);
}

// Screw model (simplified)
module screw() {
    union() {
        // Head
        cylinder(h = screw_head_depth, r = screw_head_diameter/2, $fn=50);
        // Shaft
        translate([0, 0, screw_head_depth])
            cylinder(h = 10, d = screw_diameter, $fn=50);
    }
}

// Render the model
flexible_coupling();

