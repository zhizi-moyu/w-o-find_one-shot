
// Parameters
shaft_d = 20;
shaft_l = 80;

flange_d = 40;
flange_th = 8;
flange_hole_d = 5;
flange_hole_r = 15;

spacer_d = 36;
spacer_th = 2;

bolt_d = 5;
bolt_l = 16;
nut_d = 8;
nut_th = 4;

// Modules
module central_cylindrical_shaft() {
    color("gray") cylinder(d=shaft_d, h=shaft_l, $fn=100);
}

module flange_disc() {
    difference() {
        color("lightgray") cylinder(d=flange_d, h=flange_th, $fn=100);
        for (i = [0:2]) {
            angle = i * 120;
            translate([flange_hole_r * cos(angle), flange_hole_r * sin(angle), 0])
                cylinder(d=flange_hole_d, h=flange_th + 1, $fn=50);
        }
    }
}

module spacer_ring() {
    difference() {
        color("silver") cylinder(d=spacer_d, h=spacer_th, $fn=100);
        cylinder(d=shaft_d, h=spacer_th + 1, $fn=100);
    }
}

module bolt_with_nut() {
    union() {
        color("dimgray") cylinder(d=bolt_d, h=bolt_l, $fn=30);
        translate([0, 0, bolt_l])
            color("gray") cylinder(d=nut_d, h=nut_th, $fn=6);
    }
}

module flange_assembly(z_pos) {
    translate([0, 0, z_pos]) {
        flange_disc();
        for (i = [0:2]) {
            angle = i * 120;
            translate([flange_hole_r * cos(angle), flange_hole_r * sin(angle), -bolt_l + flange_th])
                rotate([90, 0, angle])
                    bolt_with_nut();
        }
    }
}

module spacer_at(z_pos) {
    translate([0, 0, z_pos]) spacer_ring();
}

// Assembly
module flexible_coupling() {
    union() {
        // Shaft
        translate([0, 0, 0]) central_cylindrical_shaft();

        // Left side
        spacer_at(0);
        flange_assembly(0);

        // Right side
        spacer_at(shaft_l - spacer_th);
        flange_assembly(shaft_l - flange_th);
    }
}

// Render the model
flexible_coupling();


