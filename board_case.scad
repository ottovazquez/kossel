include <configuration.scad>;

height = 35;
thickness = 3;
standoff = 3.5;

board_length = 100;
board_width = 60 + 1; 	// add 1mm to have space enough to insert the board
board_height = 2;
board_offset = 2 + m3_wide_radius;	

module case_frame($fn=20) {
	radius = m3_radius + 1.5;
	difference() {
		union() {	
			difference() {
				cylinder(r=board_width+thickness, h=height, $fn=6, center=true);
				translate([0,0,thickness]) 
					cylinder(r=board_width, h=height, $fn=6, center=true);
			}
			for (i = [0:60:359]) {
				// case standoffs
				rotate([0, 0, i]) hull() {
					translate([board_width - radius/4, 0, (height-standoff)/2]) 
						cylinder(r=radius, h=standoff, center=true);
					translate([board_width - radius/4, 0, standoff])
					cylinder(r=0.1);
				}
			}
		}

		for (i = [0:60:359]) {
			// case holes
			rotate([0, 0, i]) translate([board_width - radius/4, 0, (height-standoff)/2])
				cylinder(r=m3_radius, h=standoff + 1, center=true);
				
			// cable holes
			for (j = [-20:10:20]) {
				rotate([0, 0, 30 + i]) translate([board_width-9.5, j, (height-radius)/2])
			 		rotate([0, 90, 0]) cylinder(r=radius, h=thickness);
			}
		}
	}
}

module board_case($fn=20) {
	difference() {
		union(){
			case_frame();
			// standoffs
			translate([0, 0, -height/2 + thickness + standoff/2])
			for (i = [-1, 1]) {
				for (j = [-1, 1]) {			
					translate([i*board_width/2 - i*board_offset, j*board_length/2 - j*board_offset, 0]) 
						difference() {
							cylinder(r1=m3_washer_radius+1, r2=m3_washer_radius-1, h=standoff, center=true);			
							cylinder(r=m3_radius, h=standoff + 1, center=true);		
						}
				}
			}
		}
		// frame rail
		for (i = [-1, 1]) {
			hull() {
				translate([i * 36, i * inner_radius/5, 0]) 
					cylinder(r=m3_wide_radius + extra_radius, h=height+1, center=true);
				translate([i * 36,-i * inner_radius/5,  0]) 
					cylinder(r=m3_wide_radius + extra_radius, h=height+1, center=true);
			}
		}
	}
}

board_case();
