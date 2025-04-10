
// Parameters
bracket_thickness = 4;
horizontal_length = 60;
vertical_height = 50;
bracket_width = 15;

slot_length = 20;
slot_width = 6;
slot_depth = 2;

peg_radius = 4;
peg_height = 6;

// Main L-bracket
module angled_mounting_bracket() {
    difference() {
        union() {
            // Horizontal arm
            cube([horizontal_length, bracket_width, bracket_thickness]);

            // Vertical arm
            translate([0, 0, bracket_thickness])
                cube([bracket_thickness, bracket_width, vertical_height]);

            // Cylindrical peg on bottom
            translate([horizontal_length - 15, bracket_width / 2, -peg_height])
                rotate([90, 0, 0])
                    cylinder(h = peg_height, r = peg_radius, $fn = 50);
        }

        // Recessed slot on top of horizontal arm
        translate([10, (bracket_width - slot_width) / 2, bracket_thickness - slot_depth])
            cube([slot_length, slot_width, slot_depth]);
    }
}

// Render the bracket
angled_mounting_bracket();

