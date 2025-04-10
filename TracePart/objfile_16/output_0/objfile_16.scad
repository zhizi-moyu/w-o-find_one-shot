```scad
$fn = 100; // Smoothness

// Parameters
hub_d = 30;
hub_h = 20;
bore_d = 10;

flange_d = 60;
flange_h = 5;
bolt_hole_d = 5;
bolt_circle_d = 45;

spacer_thickness = 2;

bolt_d = 5;
bolt_len = flange_h + spacer_thickness + flange_h;

insert_d = 10;
insert_len = 20;

// Modules
module cylindrical_hub() {
    difference() {
        cylinder(d=hub_d, h=hub_h);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=hub_h + 2);
    }
}

module flanged_disk() {
    difference() {
        union() {
            cylinder(d=flange_d, h=flange_h);
            translate([0, 0, flange_h])
                cylinder(d=hub_d, h=hub_h);
        }
        // Central bore
        translate([0, 0, -1])
            cylinder(d=bore_d, h=flange_h + hub_h + 2);
        // Bolt holes
        for (i = [0:3]) {
            angle = i * 90;
            x = bolt_circle_d / 2 * cos(angle);
            y = bolt_circle_d / 2 * sin(angle);
            translate([x, y, 0])
                cylinder(d=bolt_hole_d, h=flange_h + 1);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=flange_d, h=spacer_thickness);
        translate([0, 0, -1])
            cylinder(d=hub_d, h=spacer_thickness + 2);
    }
}

module hex_bolt() {
    translate([0, 0, -bolt_len])
        cylinder(d=bolt_d, h=bolt_len);
}

module central_insert() {
    cylinder(d=insert_d, h=insert_len);
}

// Assembly
module flexible_coupling() {
    // Left hub
    translate([0, 0, 0])
        cylindrical_hub();

    // Left flange
    translate([0, 0, hub_h])
        flanged_disk();

    // Spacer
    translate([0, 0, hub_h + flange_h])
        spacer_ring();

    // Right flange
    translate([0, 0, hub_h + flange_h + spacer_thickness])
        flanged_disk();

    // Right hub
    translate([0, 0, hub_h + flange_h + spacer_thickness + flange_h])
        cylindrical_hub();

    // Bolts
    for (i = [0:3]) {
        angle = i * 90;
        x = bolt_circle_d / 2 * cos(angle);
        y = bolt_circle_d / 2 * sin(angle);
        translate([x, y, hub_h + flange_h + spacer_thickness])
            hex_bolt();
    }

    // Central shaft insert
    translate([0, 0, hub_h + flange_h - insert_len / 2])
        central_insert();
}

// Render the full assembly
flexible_coupling();
```

