
$fn = 100;

// Parameters
hub_d = 20;
hub_l = 30;
flange_d = 40;
flange_t = 5;
bolt_hole_d = 4;
bolt_circle_d = 30;
disc_t = 1;
spacer_t = 10;
bolt_l = hub_l*2 + flange_t*2 + disc_t*2 + spacer_t;
bolt_d = 4;

// Helper: bolt hole positions
module bolt_holes() {
    for (i = [0:2]) {
        angle = i * 120;
        x = bolt_circle_d/2 * cos(angle);
        y = bolt_circle_d/2 * sin(angle);
        translate([x, y, 0]) circle(d=bolt_hole_d);
    }
}

// Flanged Shaft Hub
module flanged_shaft_hub() {
    union() {
        // Shaft
        cylinder(d=hub_d, h=hub_l);
        // Flange
        translate([0, 0, hub_l])
            difference() {
                cylinder(d=flange_d, h=flange_t);
                linear_extrude(height=flange_t)
                    bolt_holes();
            }
    }
}

// Flexible Disc Element
module flexible_disc() {
    difference() {
        cylinder(d=flange_d, h=disc_t);
        translate([0, 0, 0])
            linear_extrude(height=disc_t)
                bolt_holes();
    }
}

// Spacer Ring
module spacer_ring() {
    difference() {
        cylinder(d=flange_d, h=spacer_t);
        translate([0, 0, 0])
            linear_extrude(height=spacer_t)
                bolt_holes();
    }
}

// Bolt with Nut
module bolt_with_nut() {
    union() {
        cylinder(d=bolt_d, h=bolt_l);
        translate([0, 0, bolt_l])
            cylinder(d=6, h=2); // Nut
    }
}

// Assembly
module coupling_assembly() {
    // Layer 1: Hub 1
    translate([0, 0, 0])
        flanged_shaft_hub();

    // Layer 2: Disc 1
    translate([0, 0, hub_l + flange_t])
        flexible_disc();

    // Layer 3: Spacer
    translate([0, 0, hub_l + flange_t + disc_t])
        spacer_ring();

    // Layer 4: Disc 2
    translate([0, 0, hub_l + flange_t + disc_t + spacer_t])
        flexible_disc();

    // Layer 5: Hub 2
    translate([0, 0, hub_l + flange_t + disc_t*2 + spacer_t])
        mirror([0, 0, 1])
            flanged_shaft_hub();

    // Layer 6: Bolts
    for (i = [0:2]) {
        angle = i * 120;
        x = bolt_circle_d/2 * cos(angle);
        y = bolt_circle_d/2 * sin(angle);
        translate([x, y, 0])
            bolt_with_nut();
    }
}

coupling_assembly();

