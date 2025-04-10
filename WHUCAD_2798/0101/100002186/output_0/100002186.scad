
// Parameters
cylinder_height = 30;
cylinder_radius = 10;
hex_radius = 5.5; // Distance from center to flat of hex
hex_depth = 5;
chamfer_height = 5;

// Main cylindrical body
module main_body() {
    cylinder(h = cylinder_height - chamfer_height, r = cylinder_radius, $fn = 100);
}

// Chamfered bottom
module chamfered_bottom() {
    translate([0, 0, -(chamfer_height)])
        cylinder(h = chamfer_height, r1 = cylinder_radius, r2 = 0, $fn = 100);
}

// Hex socket
module hex_socket() {
    translate([0, 0, cylinder_height - hex_depth])
        rotate([0, 0, 30]) // Align flat edge to front
            linear_extrude(height = hex_depth)
                polygon(points = [
                    [hex_radius*cos(0), hex_radius*sin(0)],
                    [hex_radius*cos(60), hex_radius*sin(60)],
                    [hex_radius*cos(120), hex_radius*sin(120)],
                    [hex_radius*cos(180), hex_radius*sin(180)],
                    [hex_radius*cos(240), hex_radius*sin(240)],
                    [hex_radius*cos(300), hex_radius*sin(300)]
                ]);
}

// Final model
difference() {
    union() {
        main_body();
        chamfered_bottom();
    }
    hex_socket();
}

