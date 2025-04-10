
// Parameters
base_length = 60;
base_width = 40;
base_height = 20;
hole_radius = 3;
pivot_radius = 2.5;
pivot_length = base_width + 10;
arm_thickness = 6;
arm_radius = 20;
arm_length = 30;
wedge_width = 6;
wedge_height = 10;
wedge_length = 20;
brace_width = 6;
brace_height = 15;
brace_length = 20;
core_radius = 10;
core_height = base_height;

// Modules
module base_block() {
    difference() {
        cube([base_length, base_width, base_height], center = true);
        // Mounting holes
        for (x = [-20, 20], y = [-15, 15])
            translate([x, y, 0])
                cylinder(h = base_height + 2, r = hole_radius, center = true);
        // Central cylindrical cavity
        translate([0, 0, 0])
            cylinder(h = base_height + 2, r = core_radius, center = true);
        // Side pivot holes
        for (y = [-base_width/2, base_width/2])
            translate([0, y, 0])
                rotate([90, 0, 0])
                    cylinder(h = base_width + 2, r = pivot_radius, center = true);
    }
}

module rotary_clamp_arm(mirror_arm = false) {
    translate([0, 0, base_height/2])
        rotate([0, 0, mirror_arm ? 180 : 0])
            difference() {
                // Curved arm body
                rotate_extrude(angle = 90)
                    translate([arm_radius, 0, 0])
                        square([arm_thickness, arm_length]);
                // Pivot hole
                translate([0, 0, arm_length/2])
                    rotate([90, 0, 0])
                        cylinder(h = arm_thickness + 2, r = pivot_radius, center = true);
                // Locking notch
                translate([0, 0, arm_length - 5])
                    cube([wedge_width, arm_thickness, 2], center = true);
            }
}

module pivot_pin() {
    translate([0, 0, base_height/2])
        rotate([90, 0, 0])
            cylinder(h = pivot_length, r = pivot_radius, center = true);
}

module locking_wedge() {
    translate([0, 0, base_height + 5])
        rotate([0, 0, 0])
            linear_extrude(height = wedge_height)
                polygon(points=[[0,0],[wedge_length,0],[wedge_length/2,wedge_width]]);
}

module side_brace(mirror_brace = false) {
    translate([0, mirror_brace ? -base_width/2 - brace_width/2 : base_width/2 + brace_width/2, base_height/2])
        difference() {
            cube([brace_length, brace_width, brace_height], center = true);
            // Pivot hole
            translate([0, 0, 0])
                rotate([90, 0, 0])
                    cylinder(h = brace_width + 2, r = pivot_radius, center = true);
        }
}

module cylindrical_joint_core() {
    translate([0, 0, 0])
        cylinder(h = core_height, r = core_radius, center = true);
}

// Assembly
module assembly() {
    base_block();
    translate([0, 0, 0])
        cylindrical_joint_core();
    translate([0, 0, 0])
        rotary_clamp_arm(false);
    translate([0, 0, 0])
        rotary_clamp_arm(true);
    pivot_pin();
    locking_wedge();
    side_brace(false);
    side_brace(true);
}

// Render the full model
assembly();


