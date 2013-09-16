// borosilicate glass from http://goo.gl/btgYxZ

include <configuration.scad>;

glass_thickness=4.1;
tab_thickness=1.5;

height=2*tab_thickness + glass_thickness;

glass_radius=100;
glass_edge_radius=height/4;
lock_radius=7;

module glass_lock($fn=50) {
	difference() {
		cylinder(r=lock_radius, h=height, center=true);

		// screw hole
		cylinder(r=m3_wide_radius, h=height + 1, center=true);
		// screw head hole
		translate([0, 0, height/2]) 
			cylinder(r=m3_head_radius, h=height, center=true);	
	
		// edge
		translate([lock_radius+glass_radius, 0, 0]) 
			cylinder(r=glass_radius, h=2*glass_thickness+1, center=true);
		// glass insert
		intersection() {
			cube([lock_radius*2, lock_radius*2, glass_thickness], center=true);
			translate([lock_radius + glass_radius - glass_thickness/2, 0, 0]) 
				rotate_extrude(convexity=10, center=true)
					translate([glass_radius - glass_edge_radius, 0, 0])
						circle(r=2.8, center=true);
		}
	}
}

glass_lock();