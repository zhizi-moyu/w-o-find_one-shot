
// Parameters
bracket_thickness = 5;
bracket_length = 40;
bracket_height = 40;
hole_radius = 8;
mount_hole_radius = 2.5;
mount_hole_offset = 5;
slot_width = 5;
slot_height = 15;
slot_offset_x = 10;
slot_offset_y = 10;

// Main L-bracket
module l_bracket() {
    difference() {
        union() {
            // Base plate
            cube([bracket_length, bracket_length, bracket_thickness]);

            // Vertical plate
            translate([0, 0, bracket_thickness])
                cube([bracket_thickness, bracket_length, bracket_height]);
        }

        // Central hole in base
        translate([bracket_length/2, bracket_length/2, -1])
            cylinder(h = bracket_thickness + 2, r = hole_radius, $fn=64);

        // Mounting holes in base
        for (x = [mount_hole_offset, bracket_length - mount_hole_offset])
            for (y = [mount_hole_offset, bracket_length - mount_hole_offset])
                translate([x, y, -1])
                    cylinder(h = bracket_thickness + 2, r = mount_hole_radius, $fn=32);

        // Vertical slots
        for (y = [slot_offset_y, bracket_length - slot_offset_y - slot_height])
            translate([-1, y, bracket_thickness + 10])
                rotate([0, 90, 0])
                    rounded_slot(slot_height, slot_width, bracket_thickness + 2);
    }
}

// Rounded slot module
module rounded_slot(length, width, depth) {
    hull() {
        translate([0, 0, 0])
            cylinder(h = depth, r = width/2, $fn=32);
        translate([length, 0, 0])
            cylinder(h = depth, r = width/2, $fn=32);
    }
}

// Render the bracket
l_bracket();

 
