
$fn = 100; // Smoothness

// Parameters
coupling_diameter = 30;
coupling_length = 40;
bore_diameter = 10;
mount_hole_diameter = 5;
mount_hole_offset = 10;
slot_width = 2;
slot_depth = 25;
num_slots = 6;
slot_spacing = 5;

// Main body
difference() {
    // Outer cylinder
    cylinder(h = coupling_length, d = coupling_diameter, center = true);

    // Central bore
    translate([0, 0, -coupling_length/2])
        cylinder(h = coupling_length, d = bore_diameter, center = false);

    // Mounting holes (2 on each end)
    for (angle = [0, 180]) {
        rotate([0, 0, angle])
            translate([mount_hole_offset, 0, -coupling_length/2 + 5])
                rotate([90, 0, 0])
                    cylinder(h = coupling_diameter, d = mount_hole_diameter, center = true);
        rotate([0, 0, angle])
            translate([mount_hole_offset, 0, coupling_length/2 - 5])
                rotate([90, 0, 0])
                    cylinder(h = coupling_diameter, d = mount_hole_diameter, center = true);
    }

    // Helical slots (simulated with rotated cuts)
    for (i = [0:num_slots-1]) {
        rotate([0, 0, i * 360 / num_slots])
            translate([-coupling_diameter/2, -slot_width/2, -coupling_length/2 + 5 + i * slot_spacing])
                rotate([0, 0, 20])
                    cube([coupling_diameter, slot_width, slot_depth], center = false);
    }
}


