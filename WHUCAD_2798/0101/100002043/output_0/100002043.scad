
// Parameters for the cylindrical ring
outer_diameter = 40;  // Outer diameter of the ring
inner_diameter = 20;  // Inner hole diameter
height = 10;          // Thickness of the ring

difference() {
    // Outer cylinder
    cylinder(h = height, d = outer_diameter, $fn = 100);
    
    // Inner hole
    cylinder(h = height + 1, d = inner_diameter, $fn = 100); // Slightly taller to ensure clean subtraction
}

