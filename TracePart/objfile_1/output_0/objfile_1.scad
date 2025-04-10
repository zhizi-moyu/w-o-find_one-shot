$fn = 100; // Smoothness

// Parameters
outer_diameter = 40;
outer_length = 60;
wall_thickness = 3;
slit_width = 2;
cutout_width = 10;
cutout_height = 20;
cutout_depth = 10;
bore_diameter = 10;
pin_diameter = 4;
pin_length = 10;

// Outer cylindrical shell
module outer_shell() {
    difference() {
        cylinder(d=outer_diameter, h=outer_length);

        // Horizontal slit
        translate([0, -outer_diameter/2, outer_length/2 - slit_width/2])
            cube([outer_diameter, slit_width, slit_width], center=false);

        // Vertical cutout
        translate([outer_diameter/2 - cutout_depth, -cutout_width/2, outer_length/2 - cutout_height/2])
            cube([cutout_depth, cutout_width, cutout_height], center=false);
    }
}

// Inner rotary joint
module inner_joint() {
    difference() {
        // Main body
        cylinder(d=outer_diameter - 2*wall_thickness, h=outer_length - 10);

        // Central bore
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=outer_length + 2);

        // Tab for vertical cutout
        translate([outer_diameter/2 - wall_thickness*2, -cutout_width/2, (outer_length - 10)/2 - cutout_height/4])
            cube([cutout_depth, cutout_width, cutout_height/2], center=false);
    }
}

// Locking pin
module locking_pin() {
    translate([0, outer_diameter/2 - pin_diameter/2, outer_length/2])
        rotate([90, 0, 0])
            cylinder(d=pin_diameter, h=pin_length, center=true);
}

// Assembly
module flexible_coupling() {
    outer_shell();
    translate([0, 0, 5])
        inner_joint();
    locking_pin();
}

flexible_coupling();


