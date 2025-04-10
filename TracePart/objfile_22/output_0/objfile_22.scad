
// Parameters
$fn = 100;
cap_d = 40;
cap_h = 10;
hub_d = 30;
hub_h = 20;
disk_d = 40;
disk_th = 4;
pin_d = 4;
pin_l = 10;
nut_flat_d = 8;
nut_depth = 4;

// Modules
module cylindrical_end_cap() {
    difference() {
        cylinder(h = cap_h, d = cap_d);
        // Central hole
        translate([0, 0, -1])
            cylinder(h = cap_h + 2, d = hub_d);
        // Locking pin hole
        translate([cap_d/2 - 5, 0, cap_h/2])
            rotate([0, 90, 0])
                cylinder(h = 10, d = pin_d);
        // Hex nut insert
        translate([cap_d/2 - 5, -nut_flat_d/2, cap_h/2 - nut_depth/2])
            rotate([0, 90, 0])
                hex_nut_cavity(nut_flat_d, nut_depth);
    }
}

module hex_nut_cavity(flat_d, depth) {
    rotate([0, 0, 0])
        linear_extrude(height = depth)
            polygon(points = [
                [cos(0)*flat_d/2, sin(0)*flat_d/2],
                [cos(60)*flat_d/2, sin(60)*flat_d/2],
                [cos(120)*flat_d/2, sin(120)*flat_d/2],
                [cos(180)*flat_d/2, sin(180)*flat_d/2],
                [cos(240)*flat_d/2, sin(240)*flat_d/2],
                [cos(300)*flat_d/2, sin(300)*flat_d/2]
            ]);
}

module inner_cylindrical_hub() {
    difference() {
        cylinder(h = hub_h, d = hub_d);
        // Central bore
        translate([0, 0, -1])
            cylinder(h = hub_h + 2, d = 10);
        // Locking pin hole
        translate([hub_d/2 - 5, 0, hub_h/2])
            rotate([0, 90, 0])
                cylinder(h = 10, d = pin_d);
    }
}

module central_disk_with_curved_slots() {
    difference() {
        cylinder(h = disk_th, d = disk_d);
        // S-shaped slots (simplified as curved arcs)
        for (i = [-1, 1]) {
            translate([0, 0, 0])
                rotate([0, 0, i * 30])
                    translate([10, -2, 0])
                        cube([20, 4, disk_th + 1], center = false);
        }
    }
}

module locking_pin() {
    cylinder(h = pin_l, d = pin_d);
}

// Assembly
module flexible_coupling() {
    // Layer 1
    translate([0, 0, 0])
        cylindrical_end_cap();
    translate([0, 0, cap_h])
        inner_cylindrical_hub();
    translate([cap_d/2 - 5, 0, cap_h + hub_h/2 - pin_l/2])
        rotate([0, 90, 0])
            locking_pin();

    // Layer 3
    translate([0, 0, cap_h + hub_h])
        central_disk_with_curved_slots();
    translate([0, 0, cap_h + hub_h + disk_th])
        central_disk_with_curved_slots();

    // Layer 4
    translate([0, 0, cap_h + hub_h + 2 * disk_th])
        inner_cylindrical_hub();
    translate([cap_d/2 - 5, 0, cap_h + 2 * hub_h + 2 * disk_th - pin_l/2])
        rotate([0, 90, 0])
            locking_pin();

    // Layer 5
    translate([0, 0, cap_h + 2 * hub_h + 2 * disk_th])
        cylindrical_end_cap();
}

// Render the full assembly
flexible_coupling();


