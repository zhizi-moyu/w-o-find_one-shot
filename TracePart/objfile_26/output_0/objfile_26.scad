
// Module for the central rotational shaft
module central_rotational_shaft() {
    difference() {
        union() {
            // Main shaft body - stepped cylindrical sections
            cylinder(h=10, r=6, $fn=100); // left end
            translate([0,0,10]) cylinder(h=10, r=5, $fn=100); // taper inward
            translate([0,0,20]) cylinder(h=10, r=7, $fn=100); // central bulge
            translate([0,0,30]) cylinder(h=10, r=5, $fn=100); // taper outward
            translate([0,0,40]) cylinder(h=10, r=6, $fn=100); // right end
        }

        // Cut grooves (slots) on both ends
        for (z = [2, 8, 42, 48]) {
            for (angle = [0, 90, 180, 270]) {
                rotate([0,0,angle])
                translate([4, -1, z])
                    cube([8, 2, 2], center=false);
            }
        }

        // Circular holes on both ends
        for (z = [5, 45]) {
            translate([0,0,z])
                rotate([90,0,0])
                    cylinder(h=12, r=1.2, $fn=50);
        }
    }
}

// Call the module
central_rotational_shaft();

