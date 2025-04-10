```scad
$fn = 100; // Smoothness

// Parameters
body_diameter = 40;
body_length = 50;
rib_count = 4;
rib_thickness = 2;
rib_spacing = 3;
rib_height = 3;

flange_thickness = 8;
flange_diameter = 60;
flange_hole_diameter = 5;
flange_hole_count = 8;
flange_hole_radius = 22;

shaft_bore_diameter = 15;
clamp_slit_width = 1;
clamp_hole_diameter = 5;

// Main Assembly
module flexible_coupling() {
    union() {
        // Layer 1: Split Clamp Ring
        split_clamp_ring();

        // Layer 2: Cylindrical Body with Ribs
        translate([0, 0, clamp_length()])
            cylindrical_body_with_ribs();

        // Layer 3: Flanged End Plate
        translate([0, 0, clamp_length() + body_length])
            flanged_end_plate();
    }
}

// Split Clamp Ring
module split_clamp_ring() {
    difference() {
        union() {
            cylinder(h = clamp_length(), d = body_diameter);
        }
        // Axial slit
        translate([-clamp_slit_width/2, -body_diameter, 0])
            cube([clamp_slit_width, 2*body_diameter, clamp_length()]);

        // Central bore
        translate([0, 0, -1])
            cylinder(h = clamp_length() + 2, d = shaft_bore_diameter);

        // Radial clamp hole
        translate([-body_diameter/2, 0, clamp_length()/2])
            rotate([0, 90, 0])
                cylinder(h = body_diameter, d = clamp_hole_diameter);
    }
}

function clamp_length() = 15;

// Cylindrical Body with Ribs
module cylindrical_body_with_ribs() {
    union() {
        // Main body
        cylinder(h = body_length, d = body_diameter);

        // Ribs
        for (i = [0:rib_count-1]) {
            translate([0, 0, i*(rib_thickness + rib_spacing) + 5])
                cylinder(h = rib_thickness, d = body_diameter + 2*rib_height);
        }

        // Central bore
        translate([0, 0, -1])
            cylinder(h = body_length + 2, d = shaft_bore_diameter);
    }
}

// Flanged End Plate
module flanged_end_plate() {
    difference() {
        // Flange base
        cylinder(h = flange_thickness, d = flange_diameter);

        // Central bore
        translate([0, 0, -1])
            cylinder(h = flange_thickness + 2, d = shaft_bore_diameter);

        // Bolt holes
        for (i = [0:flange_hole_count-1]) {
            angle = 360 / flange_hole_count * i;
            x = flange_hole_radius * cos(angle);
            y = flange_hole_radius * sin(angle);
            translate([x, y, 0])
                cylinder(h = flange_thickness + 1, d = flange_hole_diameter);
        }
    }

    // Add screws
    for (i = [0:flange_hole_count-1]) {
        angle = 360 / flange_hole_count * i;
        x = flange_hole_radius * cos(angle);
        y = flange_hole_radius * sin(angle);
        translate([x, y, flange_thickness])
            rotate([0, 0, angle])
                hex_socket_head_screw();
    }
}

// Hex Socket Head Screw
module hex_socket_head_screw() {
    union() {
        // Shaft
        cylinder(h = 6, d = 4);

        // Head
        translate([0, 0, 6])
            cylinder(h = 2, d = 6);
    }
}

// Render the model
flexible_coupling();
```

