include <configuration.scad>;
use <board_case.scad>;

height = extrusion * 3;
thickness = 4.2;

wall_width = 22;
base_width = 15;

module plug($fn=20, center=true) {
	union() {
		hull() {
			translate([-6, 0, 0]) cylinder(r=4.5, h=2.2, center=true);	
			translate([6, 0, 0]) cylinder(r=4.5, h=2.2, center=true);
		}
		// add extra 0.1mm width
		hull() {
			translate([-4.5 - extra_radius, 0, 3.5]) cube([3, 9.2, 9], center=true);
			translate([1.5 + extra_radius, 0, 3.5]) cylinder(r=4.6, h=9, center=true);
		}
		translate([-8, 0, 3.5]) cylinder(r=m2_radius, h=9, center=true);
		translate([8, 0, 3.5]) cylinder(r=m2_radius, h=9, center=true);
	}
}

module switch() {
	union() {
		difference() {
			translate([-0.5, 0, 5]) rotate([0, 20, 0]) cube([10, 9, 5], center=true);
			translate([4, 0, 17.7]) rotate([90, 0, 0]) cylinder(r=12, h=10, $fn=100, center=true);
		}
		translate([0, 0, 5]) cube([15, 10.5, 1], center=true);
		cube([13.5, 9, 10], center=true);
	}
}

module frame(width, offset=0) {
	difference() {
		intersection() {
			// frame inner triangle
			cylinder(r=inner_radius, h=height, center=true, $fn=3);
			// diagonals
			for (i = [60:120:359]) {
				rotate([0, 0, i]) translate([0, -width/2, -height/2]) 
					cube([100, width, height]);
			}
		}
		// make room
		translate([0, 0, thickness]) 
			cylinder(r=inner_radius - 2*thickness, h=height+offset, center=true, $fn=3);
	}
}

module frame_base() {
	frame(base_width);
}

module frame_walls() {
	frame(wall_width, 2*thickness + 1);
}

module frame_board($fn=20) {	
	difference() {
		union () {
			frame_base();
			frame_walls();
		}
		// plug
		rotate([0, 0, 240]) translate([-inner_radius/2 + thickness * 1.5, 0, ]) 
			 rotate([90, 0, -90]) {
				 plug();
				% plug();
		}
		// switch		
		rotate([90, 0, 120]) translate([-inner_radius/2 + thickness, 0, 0])  
			rotate([0, 270, 0]) {
			switch();
			 % switch();
		}
		// wall holes
		for (i = [30:120:359]) {
			for (j = [-1, 1]) {						
				translate([0, 0, j*height/3]) rotate([90, 0, i]) 
					cylinder(r=m3_wide_radius, h=inner_radius+1, center=true);
			}
		}
		// case holes
		for (i = [60:120:359]) {
			rotate([0, 0 , i]) translate([inner_radius/4, 0, 0])
				cylinder(r=2.6, h=inner_radius, center=true);
		}
	}
}

frame_board();
rotate([0, 0, 90]) 
	% board_case();

