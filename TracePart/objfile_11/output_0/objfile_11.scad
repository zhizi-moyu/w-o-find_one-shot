
// Parameters
piston_diameter = 40;
piston_height = 50;
groove_depth = 1;
groove_width = 2;
groove_spacing = 3;
num_grooves = 3;
pin_diameter = 10;
pin_length = 50;
pin_offset = piston_height / 2;
retaining_ring_diameter = 12;
retaining_ring_thickness = 1.5;
retaining_ring_depth = 1;
cutout_depth = 5;
cutout_width = 20;
cutout_height = 10;

// Main Assembly
module piston_assembly() {
    piston_body();
    piston_pin();
    retaining_ring(-1);
    retaining_ring(1);
}

// Piston Body
module piston_body() {
    difference() {
        union() {
            // Main body
            cylinder(h = piston_height, d = piston_diameter, $fn=100);

            // Grooves
            for (i = [0:num_grooves-1]) {
                translate([0, 0, piston_height - (i+1)*(groove_width + groove_spacing)])
                    cylinder(h = groove_width, d = piston_diameter + groove_depth*2, $fn=100);
            }
        }

        // Horizontal bore for piston pin
        translate([-pin_length/2, 0, pin_offset])
            rotate([0, 90, 0])
                cylinder(h = pin_length, d = pin_diameter, $fn=100);

        // Bottom cutout
        translate([-cutout_width/2, -piston_diameter/2, 0])
            cube([cutout_width, piston_diameter, cutout_height]);

        // Retaining ring holes
        for (side = [-1, 1]) {
            translate([side*(pin_length/2 - retaining_ring_thickness/2), 0, pin_offset])
                rotate([0, 90, 0])
                    cylinder(h = retaining_ring_thickness, d = retaining_ring_diameter, $fn=100);
        }
    }
}

// Piston Pin
module piston_pin() {
    translate([-pin_length/2, 0, pin_offset])
        rotate([0, 90, 0])
            cylinder(h = pin_length, d = pin_diameter, $fn=100);
}

// Retaining Ring
module retaining_ring(side = 1) {
    translate([side*(pin_length/2 - retaining_ring_thickness/2), 0, pin_offset])
        rotate([0, 90, 0])
            color("black")
                cylinder(h = retaining_ring_thickness, d = retaining_ring_diameter, $fn=100);
}

// Render the assembly
piston_assembly();


