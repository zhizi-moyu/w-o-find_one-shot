
// Parameters
$fn = 100; // smoothness

// Component 1: Curved Top Wedge Block
module curved_top_wedge_block() {
    difference() {
        // Base wedge
        polyhedron(
            points=[
                [0,0,0], [20,0,0], [10,10,0], // base triangle
                [0,0,10], [20,0,10], [10,10,15] // top curved triangle
            ],
            faces=[
                [0,1,2], [3,4,5],
                [0,1,4,3], [1,2,5,4], [2,0,3,5]
            ]
        );
    }
}

// Component 2: Triangular Prism with Curved Base
module triangular_prism_with_curved_base() {
    hull() {
        translate([0,0,0]) cylinder(r=10, h=1);
        translate([0,0,10]) polyhedron(
            points=[[0,0,0],[20,0,0],[10,10,0]],
            faces=[[0,1,2]]
        );
    }
}

// Component 3: Quarter Cylinder Block
module quarter_cylinder_block() {
    rotate([0,0,0])
    difference() {
        cube([20,20,10]);
        translate([0,0,0])
            rotate([0,0,0])
            cylinder(r=20, h=10, center=false, $fn=100);
    }
}

// Component 4: Curved Rectangular Wall
module curved_rectangular_wall() {
    difference() {
        translate([0,0,0])
            cylinder(r=20, h=10, center=false, $fn=100);
        translate([5,0,-1])
            cylinder(r=15, h=12, center=false, $fn=100);
    }
}

// Component 5: Tapered Curved Wedge
module tapered_curved_wedge() {
    hull() {
        translate([0,0,0]) cylinder(r=20, h=1);
        translate([0,0,20]) cylinder(r=5, h=1);
    }
}

// Component 6: Flat Rectangular Base Block
module flat_rectangular_base_block() {
    cube([40,40,5], center=true);
}

// Assembly
module assembly() {
    translate([0,0,60]) curved_top_wedge_block();
    translate([0,0,45]) triangular_prism_with_curved_base();
    translate([0,0,35]) quarter_cylinder_block();
    translate([0,0,25]) curved_rectangular_wall();
    translate([0,0,10]) tapered_curved_wedge();
    translate([-20,-20,0]) flat_rectangular_base_block();
}

assembly();


