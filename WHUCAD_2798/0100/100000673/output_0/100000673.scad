
// Parameters
thickness = 3; // Uniform thickness of the plate

// 2D profile of the asymmetrical flat plate
module asymmetrical_flat_plate() {
    polygon(points=[
        [0, 0],           // Start at bottom left
        [10, 0],          // Bottom edge
        [12, 2],          // Notch on right side
        [14, 6],          // Right edge
        [10, 10],         // Top right
        [5, 12],          // Sharp angled point
        [2, 10],          // Top left
        [1, 7],           // Concave curve start
        [0, 5],           // Concave curve end
        [-1, 3],          // Semicircular protrusion start
        [0, 0]            // Close the shape
    ]);
}

// Extrude the 2D profile to create the 3D object
linear_extrude(height = thickness)
    asymmetrical_flat_plate();

