include <configuration.scad>;

_thickness = rail_thickness + 1; // 1mm thicker than linear rail.
width = extrusion;  // Same as vertical extrusion.
height = 12;

module railstop() {
  difference() {
    union() {
      cube([width, _thickness, height], center=true);
      translate([0, 2, 0])
        cube([2.5, _thickness, height], center=true);
    }
    translate([0, (_thickness - rail_thickness )/2, height - 2]) {
    	cube([rail_width , rail_thickness, height], center=true);
		}
    rotate([90, 0, 0]) {
      cylinder(r=m3_wide_radius, h=20, center=true, $fn=12);
      translate([0, 0, 3.6-_thickness/2]) {
        cylinder(r=3, h=10, $fn=24);
      }
      translate([0, 0, -_thickness/2]) scale([1, 1, -1])
        cylinder(r1=m3_wide_radius, r2=7, h=4, $fn=24);
    }		
  }
}

translate([0, 0, height/2]) railstop();