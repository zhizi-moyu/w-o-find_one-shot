
// Parameters
length = 40;
width = 40;
height = 20;
radius = 5;

// Rounded rectangular block module
module rounded_rectangular_block() {
    // Create a cube and round the top edges using Minkowski sum
    minkowski() {
        cube([length - 2*radius, width - 2*radius, height - radius], center = false);
        translate([0, 0, height - radius])
            sphere(r=radius);
    }
}

// Call the module
translate([radius, radius, 0])
    rounded_rectangular_block();

