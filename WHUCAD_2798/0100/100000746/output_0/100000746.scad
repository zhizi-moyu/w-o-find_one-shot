
// Parameters
rod_radius = 1;         // Radius of the rod
loop_width = 30;        // Width of the loop (flat base)
loop_height = 40;       // Total height of the loop
arc_radius = loop_width / 2;  // Radius of the top arc

module bent_frame_loop() {
    // Create a 2D path for the loop
    path = [
        [0, 0],
        [0, loop_height - arc_radius],
        for (a = [90 : -1 : -90])
            [arc_radius * cos(a), loop_height - arc_radius + arc_radius * sin(a)],
        [loop_width, loop_height - arc_radius],
        [loop_width, 0]
    ];

    // Center the loop horizontally
    translate([-loop_width/2, 0, 0])
        rotate_extrude(angle = 0)  // No rotation, just use linear_extrude with offset
            offset(r = rod_radius)
                polygon(points = path);
}

// Call the module
bent_frame_loop();

