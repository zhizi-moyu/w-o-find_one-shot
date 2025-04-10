
$fn = 100;

// Parameters
end_block_d = 20;
end_block_h = 10;
shaft_bore_d = 6;
screw_d = 3;
screw_h = 10;
slit_w = 1;
flexure_d = 20;
flexure_h = 20;
slot_w = 2;
slot_d = 5;
num_slots = 6;

// Main assembly
module coupling() {
    // Top end block
    translate([0, 0, flexure_h + end_block_h])
        end_block();

    // Flexure beam
    translate([0, 0, end_block_h])
        flexure_beam();

    // Bottom end block
    end_block();
}

// End block with bore, slit, and screw holes
module end_block() {
    difference() {
        cylinder(h = end_block_h, d = end_block_d);
        // Shaft bore
        translate([0, 0, -1])
            cylinder(h = end_block_h + 2, d = shaft_bore_d);
        // Slit
        translate([end_block_d/2 - slit_w/2, -1, 0])
            cube([slit_w, end_block_d, end_block_h + 2], center = false);
        // Screw holes
        for (angle = [45, -45]) {
            rotate([0, 0, angle])
                translate([end_block_d/3, 0, end_block_h/2])
                    rotate([90, 0, 0])
                        cylinder(h = screw_h, d = screw_d);
        }
    }
    // Screws
    for (angle = [45, -45]) {
        rotate([0, 0, angle])
            translate([end_block_d/3, 0, end_block_h/2])
                rotate([90, 0, 0])
                    color("gray") cylinder(h = screw_h, d = screw_d);
    }
}

// Helical flexure beam approximation
module flexure_beam() {
    difference() {
        cylinder(h = flexure_h, d = flexure_d);
        for (i = [0:num_slots - 1]) {
            rotate([0, 0, i * 360 / num_slots])
                translate([flexure_d/2 - slot_d/2, 0, i * flexure_h / num_slots])
                    rotate([0, 90, 0])
                        cylinder(h = slot_d, d = slot_w);
        }
    }
}

coupling();

