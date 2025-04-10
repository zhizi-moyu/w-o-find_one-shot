
// Parameters
coupling_length = 40;
coupling_diameter = 15;
slot_width = 1;
slot_depth = 5;
slot_spacing = 6;
num_slots = 4;
screw_hole_diameter = 2.5;
screw_hole_offset = 6;

// Main body
difference() {
    // Base cylinder
    cylinder(h = coupling_length, d = coupling_diameter, $fn = 100);

    // Axial slots
    for (i = [0 : num_slots - 1]) {
        translate([0, 0, i * slot_spacing + 2])
            rotate([0, 0, 0])
                cube([coupling_diameter, slot_width, slot_depth], center = true);
    }

    // Screw holes (2 on each end)
    for (z = [screw_hole_offset, coupling_length - screw_hole_offset]) {
        for (angle = [0, 180]) {
            rotate([0, 0, angle])
                translate([coupling_diameter / 2 - 1, 0, z])
                    rotate([90, 0, 0])
                        cylinder(h = 5, d = screw_hole_diameter, $fn = 50);
        }
    }

    // Shaft clamping slit (through the center)
    translate([-coupling_diameter / 2, -0.5, 0])
        cube([coupling_diameter, 1, coupling_length]);
}

