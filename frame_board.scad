include <configuration.scad>;
use <vertex.scad>;

height=45;
wall_thickness=4.2;
base_thickness=3.5;

board_length=100;
board_width=61;

module printrboard($fn=20) {
	offset= 2 + m3_wide_radius;	
	difference() {
		translate([0,0,2]) cube([board_length, board_width, 2], center=true);
		for (i = [-1, 1]) {
			for (j = [-1, 1]) {			
				translate([i*board_length/2 - i*offset, j*board_width/2 -j*offset, -1]) {
					cylinder(r=m3_radius, h=5);
				}
			}
		}
	}
}

module plug($fn=20, center=true) {
	%translate([0,-1,0]) cube([12,9,9], center=true);
	union() {
		hull() {
			translate([-6,0,0]) cylinder(r=4.5, h=2.2, center=true);	
			translate([6,0,0]) cylinder(r=4.5, h=2.2, center=true);
		}
		hull() {
			translate([-4.5,0,3.5]) cube([3,9,9], center=true);
			translate([1.5,0,3.5]) cylinder(r=4.5, h=9, center=true);
		}
	
	translate([-8.3,0,3.5]) cylinder(r=1, h=9, center=true);
	translate([8.3,0,3.5]) cylinder(r=1, h=9, center=true);
	}
}

module switch() {
	difference() {
		translate([-0.5,0,5]) rotate([0,20,0]) cube([10,9,5],center=true);
		translate([4,0,17.7]) rotate([90,0,0]) cylinder(r=12,h=10, $fn=100, center=true);
	}
	translate([0,0,5]) cube([15,10.5,1],center=true);
	cube([13.5,9,10],center=true);
}

module frame_board($fn=3) {
	union() {
		difference() {
			intersection() {
				union() {
					translate([k_inner_height/3,0,0]) rotate([0,0,180]) 
				 		cylinder(r=k_inner_height/2, h=height, center=true);
					translate([k_inner_height/6,0,0])
					 	cylinder(r=k_inner_height/3, h=height, center=true);
				}
				difference() {
					translate([k_inner_height/3,0,0]) cylinder(r=k_outer_radius, h=height+1, center=true);
					translate([k_outer_radius+2*wall_thickness,0,0]) cylinder(r=k_inner_height/3+1, h=height+2, center=true);
					translate([100/2,-board_width-2,0]) 
						cube([100 + 30,board_width, height+2], center=true);
					translate([100/2 ,board_width+2,0]) 
						cube([100 + 30,board_width, height+2], center=true);
				}
			}	
			// walls
			translate([k_inner_height/3,0,base_thickness]) 
				cylinder(r=k_outer_radius-(2*wall_thickness), h=height, center=true);	
			translate([k_inner_height/2,0,extrusion]) 
				cylinder(r=k_outer_radius-(2*wall_thickness), h=height, center=true);	
			// switch
			translate([wall_thickness,board_width/4,0])rotate([90,0,270]) {
				switch();
				% switch();
			}
			// plug
			translate([wall_thickness+2,-board_width/4,0]) rotate([90,0,270]) {
				plug();
				% plug();
			}
			// back and side holes
			for (i = [-1, 1]) {
				for (j = [-1, 1]) {			
					translate([-0.1, j*20, i*15]) rotate([0, 90, 0]) screw_socket();
					translate([k_inner_height/2, j*73, i*15]) rotate([-j*60, 90, 180]) screw_socket();
				}
			}
		}
	}
}

module frame_printrboard() {
	% translate([82,0,base_thickness-height/2 + 2]) printrboard();
	difference() {
		union() {
			frame_board();
			// standoffs
			for (i = [-1, 1]) {
				translate([36,i*board_width/2 -i*3.75,base_thickness-height/2])
					cylinder(r1=m3_nut_radius+1, r2=m3_radius+1, h=3.5, $fn=20);
				translate([board_length+28.2,i*board_width/2 -i*3.75,base_thickness-height/2])
					cylinder(r1=m3_nut_radius+1, r2=m3_radius+1, h=3.5, $fn=20);
			}
		}
		// base
		for (i = [-1, 1]) {
			hull() {
				translate([46,i*board_width/4-i*2,(wall_thickness-height)/2])
					cylinder(r=board_width/6, h=wall_thickness+2, $fn=20, center=true);
				translate([118,i*board_width/4-i*2,(wall_thickness-height)/2]) 
					cylinder(r=board_width/6, h=wall_thickness+2, $fn=20, center=true);
			}
		}
		// nuts holes
		for (i = [-1, 1]) {
			for (j = [36, 128.2]) {	
				translate([j,i*board_width/2 -i*3.75,-height/2-1]) {
					rotate([0,0,30]) cylinder(r=m3_nut_radius, h=3.8, $fn=6);
					cylinder(r=m3_radius, h=2*wall_thickness, $fn=20);
				}
			}
		}
	}
}

translate([-k_inner_height/3,0,0]) frame_printrboard();