```scad
// Parameters
cap_diameter = 30;
cap_thickness = 8;
slot_width = 4;
slot_depth = cap_diameter;
disk_thickness = 4;
disk_diameter = 24;
rod_diameter = 4;
rod_spacing = 12;
rod_length = 24;
pin_diameter = 3;
pin_length = 6;
screw_diameter = 2;
screw_offset = 10;

// Modules
module outer_cylindrical_end_cap() {
    difference() {
        cylinder(h = cap_thickness, d = cap_diameter, $fn=100);
        // Slot
        translate([0, -slot_width/2, cap_thickness/2])
            cube([cap_diameter, slot_width, cap_thickness], center=true);
        // Screw holes
        for (angle = [0, 180]) {
            rotate([0, 0, angle])
                translate([screw_offset, 0, cap_thickness/2])
                    rotate([90, 0, 0])
                        cylinder(h = cap_thickness + 2, d = screw_diameter, $fn=50);
        }
    }
}

module inner_slotted_disk(rotate90=false) {
    difference() {
        cylinder(h = disk_thickness, d = disk_diameter, $fn=100);
        // Slot
        translate([0, -slot_width/2, 0])
            cube([disk_diameter, slot_width, disk_thickness], center=true);
    }
}

module central_connecting_rod(length=rod_length) {
    cylinder(h = length, d = rod_diameter, $fn=50);
}

module locking_pin() {
    cylinder(h = pin_length, d = pin_diameter, $fn=50);
}

module fastening_screw() {
    cylinder(h = cap_thickness + 2, d = screw_diameter, $fn=50);
}

// Assembly
module flexible_coupling() {
    // Top end cap
    translate([0, 0, 0])
        outer_cylindrical_end_cap();

    // Top screws
    for (angle = [0, 180]) {
        rotate([0, 0, angle])
            translate([screw_offset, 0, -1])
                fastening_screw();
    }

    // Connecting rods
    for (x = [-rod_spacing/2, rod_spacing/2]) {
        translate([x, 0, cap_thickness])
            central_connecting_rod(rod_length);
    }

    // Interlocked disks
    translate([0, 0, cap_thickness + rod_length/2 - disk_thickness/2])
        inner_slotted_disk();
    translate([0, 0, cap_thickness + rod_length/2 - disk_thickness/2])
        rotate([0, 0, 90])
            inner_slotted_disk();

    // Locking pin
    translate([0, 0, cap_thickness + rod_length/2 - pin_length/2])
        locking_pin();

    // Bottom end cap
    translate([0, 0, cap_thickness + rod_length])
        outer_cylindrical_end_cap();

    // Bottom screws
    for (angle = [0, 180]) {
        rotate([0, 0, angle])
            translate([screw_offset, 0, cap_thickness + rod_length - 1])
                fastening_screw();
    }
}

// Render the full model
flexible_coupling();
```

