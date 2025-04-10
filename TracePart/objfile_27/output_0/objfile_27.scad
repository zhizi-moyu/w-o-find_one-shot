
// Parameters
connector_diameter = 20;
connector_length = 40;
axial_hole_diameter = 10;

screw_diameter = 5;
screw_head_diameter = 8;
screw_head_depth = 4;
screw_offset = 10;

spacer_length = 15;
spacer_d1 = 10; // smaller end
spacer_d2 = 14; // larger end
spacer_hole_diameter = axial_hole_diameter;

// Module: Hex Socket Cap Screw
module hex_socket_cap_screw() {
    union() {
        // Screw shaft
        cylinder(h = connector_diameter, d = screw_diameter, $fn=50);
        // Screw head
        translate([0, 0, connector_diameter - screw_head_depth])
            cylinder(h = screw_head_depth, d = screw_head_diameter, $fn=50);
    }
}

// Module: Tapered Cylindrical Spacer
module tapered_cylindrical_spacer() {
    difference() {
        // Tapered body
        cylinder(h = spacer_length, d1 = spacer_d1, d2 = spacer_d2, $fn=100);
        // Axial hole
        translate([0, 0, -1])
            cylinder(h = spacer_length + 2, d = spacer_hole_diameter, $fn=50);
    }
}

// Module: Cylindrical Connector with Side Screws
module cylindrical_connector_with_side_screws() {
    difference() {
        // Main body
        cylinder(h = connector_length, d = connector_diameter, $fn=100);
        // Axial hole
        translate([0, 0, -1])
            cylinder(h = connector_length + 2, d = axial_hole_diameter, $fn=50);
        // Screw holes
        for (i = [-1, 1]) {
            translate([i * screw_offset, connector_diameter / 2, connector_length / 2])
                rotate([90, 0, 0])
                    cylinder(h = connector_diameter, d = screw_diameter, $fn=50);
        }
        // Screw head recesses
        for (i = [-1, 1]) {
            translate([i * screw_offset, connector_diameter / 2, connector_length / 2])
                rotate([90, 0, 0])
                    cylinder(h = screw_head_depth, d = screw_head_diameter, $fn=50);
        }
    }
}

// Assembly
module assembly() {
    union() {
        // Layer 1: Tapered Spacer
        translate([0, 0, 0])
            tapered_cylindrical_spacer();
        // Layer 2: Connector
        translate([0, 0, spacer_length])
            cylindrical_connector_with_side_screws();
        // Screws
        for (i = [-1, 1]) {
            translate([i * screw_offset, connector_diameter / 2, spacer_length + connector_length / 2])
                rotate([90, 0, 0])
                    hex_socket_cap_screw();
        }
    }
}

// Render the full assembly
assembly();

