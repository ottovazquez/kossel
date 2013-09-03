include <configuration.scad>;

thickness=4;
top=130;
width=64;
height=15;

module holder() {
	difference() {
		trapezoid(top, height);
		translate([thickness,0,thickness]) 
			trapezoid(top - thickness, height-thickness);
		
		// mount holes
		for(a = [-30, 20]) {
			rotate([0,90,-30]) translate([0,a,-12.2]) screw_socket();
		}
		
	}
}

module trapezoid(top, height,center=true) {
	hull() {
		translate([-top/2, 0, 0]) rotate([0,-60,0])cube([top,height,thickness], center=true);
		translate([-top/2, 0, 0]) rotate([0,60,0])cube([top,height,thickness], center=true);
	}
}


module printrboard($fn=20) {
	dimmensions=[100,61,2];
	offset= 2 + m3_wide_radius;
	
	difference() {
		cube(dimmensions, center=true);
		translate([dimmensions[0]/2 - offset, dimmensions[1]/2 -offset, 0]) 
			cylinder(r=m3_radius, h=5, center=true);
		translate([-dimmensions[0]/2 + offset, dimmensions[1]/2 -offset, 0]) 
			cylinder(r=m3_radius, h=5, center=true);
		translate([dimmensions[0]/2 - offset, -dimmensions[1]/2 + offset, 0]) 
			cylinder(r=m3_radius, h=5, center=true);
		translate([-dimmensions[0]/2 + offset, -dimmensions[1]/2 + offset, 0]) 
			cylinder(r=m3_radius, h=5, center=true);
	}
}
h = width/sin(60);
union() {
	
	translate([0, 0, 5]) % printrboard();		
	
	translate([-top/2-h/4+thickness/2, 0, height/2]) rotate([0,0,-30]) 
		cube([thickness, h,height], center=true);
	hull() {
		cube([thickness, width, 2], center=true);
		translate([-top/2-h/4+thickness/2, 0, 0]) rotate([0,0,-30]) 
			cube([thickness, h, 2], center=true);
	}
	
}

