```scad
$fn = 100;

// Parameters
body_diameter = 40;
body_length = 60;

sleeve_thickness = 3;
rib_count = 6;
rib_spacing = 5;
rib_height = 3;
rib_width = 3;

face_plate_thickness = 5;
lug_length = 6;
lug_width = 6;
lug_height = 4;

bolt_diameter = 5;
bolt_head_size = 6;
bolt_spacing_radius = 12;

socket_diameter = 10;
socket_depth = 3;

// Main Assembly
module flexible_coupling() {
    union() {
        // Central Body
        central_cylindrical_body();

        // Helical Ribbed Sleeve
        translate([0, 0, face_plate_thickness])
            helical_ribbed_sleeve();

        // Front Face Plate with Lugs
        front_face_plate_with_lugs();

        // Rear Face Plate with Socket and Bolts
        translate([0, 0, body_length - face_plate_thickness])
            rear_face_plate_with_socket();
    }
}

// Central Body
module central_cylindrical_body() {
    translate([0, 0, 0])
        cylinder(h = body_length, d = body_diameter);
}

// Helical Ribbed Sleeve
module helical_ribbed_sleeve() {
    for (i = [0 : rib_count - 1]) {
        rotate([0, 0, i * 360 / rib_count])
            translate([body_diameter / 2 - rib_width / 2, 0, i * rib_spacing])
                cube([rib_width, rib_height, rib_spacing + 1], center = false);
    }
    // Outer sleeve cylinder
    difference() {
        cylinder(h = body_length - 2 * face_plate_thickness, d = body_diameter + 2 * sleeve_thickness);
        translate([0, 0, -1])
            cylinder(h = body_length, d = body_diameter);
    }
}

// Front Face Plate with Lugs
module front_face_plate_with_lugs() {
    union() {
        // Face plate
        cylinder(h = face_plate_thickness, d = body_diameter);

        // Central hole
        difference() {
            cylinder(h = face_plate_thickness + 1, d = body_diameter);
            translate([0, 0, -1])
                cylinder(h = face_plate_thickness + 2, d = socket_diameter);
        }

        // Locking Lugs
        for (i = [0 : 2]) {
            angle = i * 120;
            rotate([0, 0, angle])
                translate([body_diameter / 2, -lug_width / 2, 0])
                    cube([lug_length, lug_width, lug_height]);
        }
    }
}

// Rear Face Plate with Socket and Bolts
module rear_face_plate_with_socket() {
    union() {
        // Face plate
        cylinder(h = face_plate_thickness, d = body_diameter);

        // Central socket
        translate([0, 0, 0])
            cylinder(h = socket_depth, d = socket_diameter);

        // Hexagonal bolts
        for (i = [0 : 2]) {
            angle = i * 120;
            x = bolt_spacing_radius * cos(angle);
            y = bolt_spacing_radius * sin(angle);
            translate([x, y, face_plate_thickness / 2])
                hex_bolt();
        }
    }
}

// Hexagonal Bolt Head
module hex_bolt() {
    rotate([0, 0, 0])
        cylinder(h = 3, d = bolt_diameter, $fn = 6);
}

// Render the model
flexible_coupling();
```

