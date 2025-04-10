
// Parameters
plate_size = 60;         // Width and height of the square plate
plate_thickness = 4;     // Thickness of the plate
corner_radius = 5;       // Radius for rounded corners
center_hole_diameter = 6; // Diameter of the central hole
recess_depth = 0.5;      // Depth of the recessed border
recess_margin = 3;       // Margin from the edge for the recessed border

module flat_square_plate_with_center_hole() {
    difference() {
        // Main plate with rounded corners
        minkowski() {
            cube([plate_size - 2*corner_radius, plate_size - 2*corner_radius, plate_thickness], center=true);
            cylinder(r=corner_radius, h=0.01);
        }

        // Central hole
        translate([0, 0, -1])
            cylinder(h=plate_thickness + 2, d=center_hole_diameter, center=true);

        // Recessed border
        translate([0, 0, plate_thickness - recess_depth])
            offset_border();
    }
}

// Recessed border module
module offset_border() {
    linear_extrude(height=recess_depth) {
        offset(delta=-recess_margin)
            offset(delta=recess_margin)
                minkowski() {
                    square([plate_size - 2*corner_radius, plate_size - 2*corner_radius], center=true);
                    circle(r=corner_radius);
                }
    }
}

// Render the component
flat_square_plate_with_center_hole();

