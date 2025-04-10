```scad
// Parameters
hub_radius = 20;
hub_thickness = 10;
hub_hole_radius = 5;
arm_radius = 30;
arm_thickness = 10;
arm_width = 12;
arm_hole_radius = 2.5;
plate_thickness = 4;
fastener_radius = 2.5;
fastener_head_radius = 4;
fastener_head_depth = 2;

// Central Hub Disk
module central_hub_disk() {
    difference() {
        cylinder(h = hub_thickness, r = hub_radius, $fn=100);
        translate([0, 0, -1])
            cylinder(h = hub_thickness + 2, r = hub_hole_radius, $fn=100);
        for (i = [0:120:360]) {
            rotate([0, 0, i])
                translate([hub_radius - 5, -arm_width/2, 0])
                    cube([10, arm_width, hub_thickness]);
        }
    }
}

// Curved Interlocking Arm
module curved_interlocking_arm() {
    difference() {
        rotate_extrude(angle=60, $fn=100)
            translate([arm_radius, 0, 0])
                square([arm_thickness, arm_width], center=true);
        for (i = [-1, 1]) {
            translate([0, i * arm_width/2, arm_thickness/2])
                rotate([90, 0, 0])
                    cylinder(h = arm_thickness, r = arm_hole_radius, $fn=50);
        }
    }
}

// Side Clamp Plate
module side_clamp_plate() {
    difference() {
        cylinder(h = plate_thickness, r = arm_radius + 5, $fn=100);
        for (i = [0:120:360]) {
            rotate([0, 0, i])
                translate([arm_radius, 0, plate_thickness/2])
                    rotate([90, 0, 0])
                        cylinder(h = plate_thickness + 2, r = fastener_radius, $fn=50);
        }
        for (i = [0:120:360]) {
            rotate([0, 0, i])
                translate([arm_radius, 0, plate_thickness - fastener_head_depth])
                    cylinder(h = fastener_head_depth + 1, r = fastener_head_radius, $fn=50);
        }
    }
}

// Hexagonal Fastener
module hexagonal_fastener() {
    union() {
        cylinder(h = plate_thickness + arm_thickness, r = fastener_radius, $fn=50);
        translate([0, 0, plate_thickness + arm_thickness])
            cylinder(h = fastener_head_depth, r = fastener_head_radius, $fn=6);
    }
}

// Assembly
module assembly() {
    // Bottom plate
    translate([0, 0, 0])
        side_clamp_plate();

    // Bottom fasteners
    for (i = [0:120:360]) {
        rotate([0, 0, i])
            translate([arm_radius, 0, 0])
                hexagonal_fastener();
    }

    // Lower arms
    for (i = [0:120:360]) {
        rotate([0, 0, i])
            translate([0, 0, plate_thickness])
                curved_interlocking_arm();
    }

    // Central hub
    translate([0, 0, plate_thickness + arm_thickness/2])
        central_hub_disk();

    // Upper arms
    for (i = [0:120:360]) {
        rotate([0, 0, i])
            translate([0, 0, plate_thickness + hub_thickness])
                curved_interlocking_arm();
    }

    // Top fasteners
    for (i = [0:120:360]) {
        rotate([0, 0, i])
            translate([arm_radius, 0, plate_thickness + hub_thickness + arm_thickness])
                hexagonal_fastener();
    }

    // Top plate
    translate([0, 0, plate_thickness + hub_thickness + 2 * arm_thickness])
        side_clamp_plate();
}

// Render the full assembly
assembly();
```

