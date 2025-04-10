```scad
// Parameters
outer_diameter = 60;
outer_thickness = 50;
wall_thickness = 5;
inner_diameter = outer_diameter - 2 * wall_thickness;
disk_thickness = 6;
cap_thickness = 4;
spacer_thickness = 2;
gear_thickness = 6;
gear_teeth = 40;
gear_tooth_depth = 1.5;
hole_radius = 5;

// Modules
module central_outer_cylinder() {
    difference() {
        cylinder(h = outer_thickness, d = outer_diameter, $fn=100);
        translate([0, 0, wall_thickness])
            cylinder(h = outer_thickness - 2 * wall_thickness, d = inner_diameter, $fn=100);
    }
}

module inner_rotor_disk() {
    difference() {
        cylinder(h = disk_thickness, d = inner_diameter, $fn=100);
        translate([0, 0, -1])
            cylinder(h = disk_thickness + 2, r = hole_radius, $fn=60);
    }
}

module end_cap_disk() {
    difference() {
        cylinder(h = cap_thickness, d = outer_diameter, $fn=100);
        translate([0, 0, -1])
            cylinder(h = cap_thickness + 2, r = hole_radius, $fn=60);
    }
}

module axial_spacer_ring() {
    difference() {
        cylinder(h = spacer_thickness, d = inner_diameter, $fn=100);
        translate([0, 0, -1])
            cylinder(h = spacer_thickness + 2, d = inner_diameter - 10, $fn=100);
    }
}

module gear_ring() {
    difference() {
        cylinder(h = gear_thickness, d = inner_diameter, $fn=100);
        for (i = [0 : gear_teeth - 1]) {
            angle = 360 / gear_teeth * i;
            rotate([0, 0, angle])
                translate([inner_diameter / 2 - gear_tooth_depth / 2, 0, 0])
                    cube([gear_tooth_depth, 2, gear_thickness], center = true);
        }
    }
}

// Assembly
module assembly() {
    // Central outer cylinder
    translate([0, 0, 0])
        central_outer_cylinder();

    // Top end cap
    translate([0, 0, outer_thickness])
        end_cap_disk();

    // Top rotor disk
    translate([0, 0, outer_thickness - cap_thickness - disk_thickness])
        inner_rotor_disk();

    // Top spacer
    translate([0, 0, outer_thickness - cap_thickness - disk_thickness - spacer_thickness])
        axial_spacer_ring();

    // Gear ring (centered)
    translate([0, 0, (outer_thickness - gear_thickness) / 2])
        gear_ring();

    // Bottom spacer
    translate([0, 0, cap_thickness + disk_thickness])
        axial_spacer_ring();

    // Bottom rotor disk
    translate([0, 0, cap_thickness])
        inner_rotor_disk();

    // Bottom end cap
    translate([0, 0, 0])
        end_cap_disk();
}

// Render the full model
assembly();
```

