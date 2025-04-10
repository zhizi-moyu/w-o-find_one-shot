```scad
// Parameters
fork_thickness = 5;
fork_length = 30;
fork_width = 20;
fork_gap = 10;
hole_diameter = 4;
hole_offset = 5;
shaft_diameter = 10;
shaft_length = 15;

mount_width = fork_gap;
mount_length = fork_length;
mount_thickness = fork_thickness;
mount_hole_diameter = hole_diameter;
mount_hole_offset = hole_offset;
mount_shaft_diameter = shaft_diameter;
mount_shaft_length = 20;

// Forked Connector Head
module forked_connector_head() {
    difference() {
        union() {
            // Left arm
            translate([0, 0, 0])
                cube([fork_thickness, fork_length, fork_width]);

            // Right arm
            translate([fork_thickness + fork_gap, 0, 0])
                cube([fork_thickness, fork_length, fork_width]);

            // Base shaft
            translate([fork_thickness, -shaft_length, fork_width/2])
                rotate([90, 0, 0])
                    cylinder(h = shaft_length, d = shaft_diameter, $fn=50);
        }

        // Holes in arms
        translate([fork_thickness/2, hole_offset, fork_width/2])
            rotate([0, 90, 0])
                cylinder(h = fork_thickness + fork_gap + fork_thickness, d = hole_diameter, $fn=50);
    }
}

// Dual-Hole Mounting Head
module dual_hole_mounting_head() {
    difference() {
        union() {
            // Mounting head
            translate([0, 0, 0])
                cube([mount_width, mount_length, mount_thickness]);

            // Shaft
            translate([mount_width/2, -mount_shaft_length, mount_thickness/2])
                rotate([90, 0, 0])
                    cylinder(h = mount_shaft_length, d = mount_shaft_diameter, $fn=50);
        }

        // Holes
        translate([mount_width/2, hole_offset, mount_thickness/2])
            rotate([0, 90, 0])
                cylinder(h = mount_width + 2, d = mount_hole_diameter, $fn=50);
    }
}

// Assembly
module assembly() {
    forked_connector_head();
    translate([fork_thickness, 0, (fork_width - mount_thickness)/2])
        dual_hole_mounting_head();
}

assembly();
```

