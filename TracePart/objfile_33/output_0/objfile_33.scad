```scad
$fn = 100;

// Parameters
hub_diameter = 40;
hub_length = 20;
bore_diameter = 10;
jaw_radius = 5;
jaw_depth = 5;
jaw_width = 8;
spider_thickness = 10;
spider_lobe_radius = 5;
screw_diameter = 4;
screw_head_diameter = 6;
screw_spacing_radius = 15;

// Main Assembly
module coupling_assembly() {
    translate([-hub_length, 0, 0])
        left_coupling_hub();
    spider_insert();
    translate([hub_length, 0, 0])
        right_coupling_hub();
    fastening_screws();
}

// Left Coupling Hub
module left_coupling_hub() {
    difference() {
        union() {
            cylinder(h = hub_length, d = hub_diameter);
            jaws();
        }
        // Bore
        translate([0, 0, -1])
            cylinder(h = hub_length + 2, d = bore_diameter);
        // Screw holes
        for (i = [0:2]) {
            angle = i * 120;
            translate([screw_spacing_radius * cos(angle), screw_spacing_radius * sin(angle), hub_length / 2])
                rotate([90, 0, 0])
                    cylinder(h = 10, d = screw_diameter);
        }
    }
}

// Right Coupling Hub (mirror of left)
module right_coupling_hub() {
    mirror([1, 0, 0])
        left_coupling_hub();
}

// Jaws (3 curved inward jaws)
module jaws() {
    for (i = [0:2]) {
        angle = i * 120;
        rotate([0, 0, angle])
            translate([hub_diameter / 2 - jaw_radius, 0, 0])
                cube([jaw_depth, jaw_width, hub_length], center = true);
    }
}

// Spider Insert
module spider_insert() {
    color("gray")
    union() {
        for (i = [0:5]) {
            angle = i * 60;
            rotate([0, 0, angle])
                translate([hub_diameter / 2 - spider_lobe_radius - 2, 0, 0])
                    cylinder(h = spider_thickness, r = spider_lobe_radius, center = true);
        }
    }
}

// Fastening Screws
module fastening_screws() {
    for (i = [0:2]) {
        angle = i * 120;
        translate([0, 0, 0])
            rotate([0, 0, angle])
                translate([screw_spacing_radius, 0, 0])
                    rotate([90, 0, 0])
                        union() {
                            cylinder(h = 20, d = screw_diameter);
                            translate([0, 0, -2])
                                cylinder(h = 2, d = screw_head_diameter);
                        }
    }
}

// Render the full assembly
coupling_assembly();
```

