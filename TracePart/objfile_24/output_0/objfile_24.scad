
// Parameters
shaft_d = 20;
shaft_len = 60;

end_cap_d = 40;
end_cap_len = 20;
end_cap_hole_d = shaft_d;

flange_d = 50;
flange_thickness = 5;
bolt_d = 3;
bolt_count = 6;
bolt_circle_d = 40;

locking_ring_d = flange_d;
locking_ring_thickness = 5;
groove_d = 2;

spacer_ring_d = flange_d;
spacer_ring_thickness = 2;

// Modules
module central_shaft() {
    color("gray") cylinder(d=shaft_d, h=shaft_len, $fn=100);
}

module cylindrical_end_cap() {
    difference() {
        cylinder(d=end_cap_d, h=end_cap_len, $fn=100);
        translate([0, 0, -1]) cylinder(d=end_cap_hole_d, h=end_cap_len + 2, $fn=100);
    }
}

module flanged_disk_with_bolts() {
    difference() {
        union() {
            cylinder(d=flange_d, h=flange_thickness, $fn=100);
        }
        for (i = [0 : 360 / bolt_count : 360 - 360 / bolt_count]) {
            angle = i;
            x = bolt_circle_d / 2 * cos(angle);
            y = bolt_circle_d / 2 * sin(angle);
            translate([x, y, 0])
                cylinder(d=bolt_d, h=flange_thickness + 2, $fn=30);
        }
    }
}

module locking_ring_with_grooves() {
    difference() {
        cylinder(d=locking_ring_d, h=locking_ring_thickness, $fn=100);
        for (i = [0 : 90 : 270]) {
            angle = i;
            x = (locking_ring_d / 2 - groove_d) * cos(angle);
            y = (locking_ring_d / 2 - groove_d) * sin(angle);
            translate([x, y, 0])
                rotate([0, 0, angle])
                    cube([groove_d, groove_d, locking_ring_thickness + 1], center=true);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=spacer_ring_d, h=spacer_ring_thickness, $fn=100);
        translate([0, 0, -1]) cylinder(d=shaft_d, h=spacer_ring_thickness + 2, $fn=100);
    }
}

// Assembly
module coupling_assembly() {
    translate([0, 0, 0]) central_shaft();

    // Left side
    translate([0, 0, 0])
        cylindrical_end_cap();
    translate([0, 0, end_cap_len])
        flanged_disk_with_bolts();
    translate([0, 0, end_cap_len + flange_thickness])
        locking_ring_with_grooves();
    translate([0, 0, end_cap_len + flange_thickness + locking_ring_thickness])
        spacer_ring();

    // Right side
    translate([0, 0, shaft_len - end_cap_len])
        cylindrical_end_cap();
    translate([0, 0, shaft_len - end_cap_len - flange_thickness])
        flanged_disk_with_bolts();
    translate([0, 0, shaft_len - end_cap_len - flange_thickness - locking_ring_thickness])
        locking_ring_with_grooves();
    translate([0, 0, shaft_len - end_cap_len - flange_thickness - locking_ring_thickness - spacer_ring_thickness])
        spacer_ring();
}

// Render the full assembly
coupling_assembly();


