// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;
m3_washer_radius = 3.5 + extra_radius;
m3_head_radius = 3 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

// Major diameter of metric 2.5mm thread.
m2_major = 2.4;
m2_radius = m2_major/2 + extra_radius;
m2_wide_radius = m2_major/2 + extra_radius + 0.2;

// NEMA17 stepper motors.
motor_shaft_diameter = 5;
motor_shaft_radius = motor_shaft_diameter/2 + extra_radius;

// Frame brackets. M3x8mm screws work best with 3.6 mm brackets.
thickness = 3.6;

// OpenBeam or Misumi. Currently only 15x15 mm, but there is a plan
// to make models more parametric and allow 20x20 mm in the future.
extrusion = 15;
extrusion_length = 240;

// HiWin, THK or Misumi
rail_width = 12;
rail_thickness = 8;

// Placement for the NEMA17 stepper motors.
motor_offset = 44;
motor_length = 47;

// Printer inner/outer dimmensions
inner_gap=27;						// distance between inner vertex cone corners
inner_offset=1.1;				// offset to fit the print into the printer frame 0.8 > 1

inner_extrusion_length = extrusion_length + 2*(inner_gap-inner_offset);
inner_height = inner_extrusion_length * sqrt(3) / 2;
inner_radius = inner_height * 2 / 3;