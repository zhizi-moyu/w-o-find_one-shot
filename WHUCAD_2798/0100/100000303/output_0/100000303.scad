
// Parameters
frame_length = 100;
frame_width = 60;
frame_thickness = 5;
cutout_margin = 10;

bracket_height = 40;
bracket_thickness = 5;
bracket_base = 30;

panel_length = 60;
panel_height = 20;
panel_thickness = 3;
panel_angle = 30;

// Base Frame
module base_frame() {
    difference() {
        cube([frame_length, frame_width, frame_thickness]);
        translate([cutout_margin, cutout_margin, -1])
            cube([frame_length - 2*cutout_margin, frame_width - 2*cutout_margin, frame_thickness + 2]);
    }
}

// Triangular Support Bracket
module triangular_bracket() {
    difference() {
        linear_extrude(height = bracket_thickness)
            polygon(points=[[0,0], [0,bracket_height], [bracket_base,0]]);
        // Circular hole
        translate([bracket_base/2, bracket_height - 10, -1])
            cylinder(h=bracket_thickness + 2, r=2, $fn=30);
    }
}

// Angled Side Panel
module angled_panel() {
    rotate([0, -panel_angle, 0])
        cube([panel_length, panel_thickness, panel_height]);
}

// Assembly
module assembly() {
    // Base Frame
    base_frame();

    // Triangular Brackets
    translate([0, 0, frame_thickness])
        triangular_bracket();
    translate([frame_length - bracket_base, 0, frame_thickness])
        mirror([1, 0, 0])
            triangular_bracket();

    // Angled Panels
    translate([0, frame_width - panel_thickness, frame_thickness + bracket_thickness])
        angled_panel();
    translate([frame_length - panel_length, 0, frame_thickness + bracket_thickness])
        mirror([1, 0, 0])
            angled_panel();
}

// Render the full assembly
assembly();

