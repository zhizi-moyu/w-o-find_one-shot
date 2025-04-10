```scad
// Parameters
bracket_thickness = 5;
vertical_height = 40;
horizontal_length = 40;
round_radius = 5;

// Module for a single L-bracket
module L_bracket() {
    difference() {
        union() {
            // Vertical arm
            cube([bracket_thickness, bracket_thickness, vertical_height]);

            // Horizontal arm
            translate([0, 0, 0])
                cube([horizontal_length, bracket_thickness, bracket_thickness]);
        }

        // Rounded outer corner on top of vertical arm
        translate([-round_radius, -round_radius, vertical_height - round_radius])
            rotate([0, 0, 0])
                cylinder(h = bracket_thickness + 1, r = round_radius, $fn = 50);
    }
}

// Assembly of two mirrored L-brackets
translate([0, 0, 0])
    L_bracket();

translate([horizontal_length, 0, 0])
    mirror([1, 0, 0])
        L_bracket();
```

