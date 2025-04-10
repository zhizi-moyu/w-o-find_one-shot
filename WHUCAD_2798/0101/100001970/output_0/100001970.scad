
// Parameters
outer_diameter = 60;
outer_height = 60;
outer_facets = 20;

recess_diameter = 30;
recess_depth = 20;

inner_diameter = 28;
inner_height = 30;

// Main assembly
module large_outer_cylinder() {
    difference() {
        // Outer faceted cylinder
        cylinder(h = outer_height, d = outer_diameter, $fn = outer_facets);
        // Recess at the bottom
        translate([0, 0, 0])
            cylinder(h = recess_depth, d = recess_diameter, $fn = 100);
    }
}

module inner_inserted_cylinder() {
    // Inserted cylinder, partially inside the recess
    translate([0, 0, - (inner_height - recess_depth)])
        cylinder(h = inner_height, d = inner_diameter, $fn = 100);
}

// Assemble the model
union() {
    large_outer_cylinder();
    inner_inserted_cylinder();
}


