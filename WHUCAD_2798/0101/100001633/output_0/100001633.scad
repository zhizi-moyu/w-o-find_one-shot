
// Parameters
tabletop_length = 100;
tabletop_width = 60;
tabletop_thickness = 4;

leg_diameter = 4;
leg_height = 60;

support_bar_thickness = 4;
support_bar_length = tabletop_width - 8; // leaving space for leg diameter

diagonal_rod_diameter = 2;
diagonal_rod_length = 40; // approximate

// Modules
module tabletop_panel() {
    color("lightgray")
    cube([tabletop_length, tabletop_width, tabletop_thickness]);
}

module vertical_leg() {
    color("gray")
    cylinder(h = leg_height, r = leg_diameter / 2, $fn = 32);
}

module horizontal_support_bar() {
    color("gray")
    cube([support_bar_length, support_bar_thickness, support_bar_thickness]);
}

module diagonal_support_rod() {
    color("gray")
    rotate([45, 0, 0])
        cylinder(h = diagonal_rod_length, r = diagonal_rod_diameter / 2, $fn = 16);
}

// Assembly
module table() {
    // Tabletop
    translate([0, 0, leg_height])
        tabletop_panel();

    // Legs
    for (x = [0, tabletop_length - leg_diameter])
        for (y = [0, tabletop_width - leg_diameter])
            translate([x, y, 0])
                vertical_leg();

    // Horizontal support bars (under tabletop, front and back)
    translate([leg_diameter, 0, leg_height - tabletop_thickness - support_bar_thickness])
        horizontal_support_bar();
    translate([leg_diameter, tabletop_width - support_bar_thickness, leg_height - tabletop_thickness - support_bar_thickness])
        horizontal_support_bar();

    // Diagonal rods (approximate positioning)
    translate([0, 0, 0])
        rotate([0, 45, 0])
            diagonal_support_rod();
    translate([tabletop_length - leg_diameter, 0, 0])
        rotate([0, -45, 0])
            diagonal_support_rod();
    translate([0, tabletop_width - leg_diameter, 0])
        rotate([0, -45, 0])
            diagonal_support_rod();
    translate([tabletop_length - leg_diameter, tabletop_width - leg_diameter, 0])
        rotate([0, 45, 0])
            diagonal_support_rod();
}

// Render the table
table();

