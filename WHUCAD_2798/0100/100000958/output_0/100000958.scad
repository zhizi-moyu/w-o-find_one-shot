```scad
$fn = 100;

// 1. Flanged Split Bushing
module flanged_split_bushing() {
    difference() {
        union() {
            cylinder(h = 15, r = 10);
            translate([0, 0, 15])
                cylinder(h = 3, r = 15);
        }
        // Central hole
        translate([0, 0, -1])
            cylinder(h = 20, r = 3);
        // Split
        translate([-1, -10, 0])
            cube([2, 20, 18]);
    }
}

// 2. Slotted Retaining Ring
module slotted_retaining_ring() {
    difference() {
        union() {
            cylinder(h = 10, r = 10);
            translate([0, 0, 10])
                cylinder(h = 2, r = 12);
        }
        // Central hole
        translate([0, 0, -1])
            cylinder(h = 15, r = 6);
        // Slot
        translate([-1, -10, 0])
            cube([2, 20, 12]);
    }
}

// 3. Cylindrical Flanged Sleeve
module cylindrical_flanged_sleeve() {
    difference() {
        union() {
            cylinder(h = 15, r = 10);
            translate([0, 0, 15])
                cylinder(h = 2, r = 12);
        }
        // Central hole
        translate([0, 0, -1])
            cylinder(h = 20, r = 6);
    }
}

// 4. Conical Centered Disk
module conical_centered_disk() {
    difference() {
        cylinder(h = 5, r = 12);
        // Conical hole
        translate([0, 0, -1])
            cylinder(h = 7, r1 = 2, r2 = 4);
    }
}

// 5. Split Flanged Socket
module split_flanged_socket() {
    difference() {
        union() {
            cylinder(h = 15, r = 12);
            translate([0, 0, 15])
                cylinder(h = 3, r = 15);
        }
        // Central hole
        translate([0, 0, -1])
            cylinder(h = 20, r = 5);
        // Internal arms (slots)
        translate([-2, -12, 0])
            cube([4, 24, 15]);
        translate([-12, -2, 0])
            cube([24, 4, 15]);
    }
}

// 6. Dual Leg Flanged Insert
module dual_leg_flanged_insert() {
    difference() {
        union() {
            cylinder(h = 10, r = 10);
            translate([0, 0, 10])
                cylinder(h = 2, r = 12);
            // Legs
            translate([-8, -2, 0])
                cube([4, 4, 10]);
            translate([4, -2, 0])
                cube([4, 4, 10]);
        }
        // Central hole
        translate([0, 0, -1])
            cylinder(h = 15, r = 3);
    }
}

// Render all components for visualization
translate([-40, 0, 0]) flanged_split_bushing();
translate([-20, 0, 0]) slotted_retaining_ring();
translate([0, 0, 0]) cylindrical_flanged_sleeve();
translate([20, 0, 0]) conical_centered_disk();
translate([40, 0, 0]) split_flanged_socket();
translate([60, 0, 0]) dual_leg_flanged_insert();
```

