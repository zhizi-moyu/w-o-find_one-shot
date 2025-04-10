
// Module to create a rounded rectangular block
module rounded_block(length, width, height, radius) {
    minkowski() {
        cube([length - 2*radius, width - 2*radius, height - 2*radius], center=true);
        sphere(r=radius, $fn=32);
    }
}

// Module to create the mounting block with holes
module rectangular_mounting_block() {
    length = 60;
    width = 30;
    height = 10;
    hole_diameter = 6;
    hole_radius = hole_diameter / 2;
    hole_offset_x = 15;
    hole_offset_y = 10;
    fillet_radius = 2;

    difference() {
        // Main block with rounded edges
        rounded_block(length, width, height, fillet_radius);

        // Through holes
        translate([0, 0, -height])
        for (x = [-hole_offset_x, hole_offset_x]) {
            translate([x, 0, height/2])
                rotate([90, 0, 0])
                    cylinder(h=width*2, r=hole_radius, center=true, $fn=64);
        }
    }
}

// Render the block
rectangular_mounting_block();

