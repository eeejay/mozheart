module pinshape(r=5,bellend=6,h=20) {
	union() {
		cylinder(r=r,h=h);
		translate([0,0,h]) sphere(r = bellend);
		}
}


module pin (h=20) {
	difference () {
		pinshape(h=h);
		translate([-10,3,h-7]) cube([20,10,30]);
		translate([-10,-13,h-7]) cube([20,10,30]);
		translate([-10,-10,h+4]) cube([20,20,10]);
		translate([0,10,6]) rotate([90, 0, 0]) linear_extrude(height=20) polygon(points=[[0,0],[-10,100],[10,100]],paths=[ [0,1,2] ]);
	}
}

module pinhole (h=20) {
		pinshape(r=5.25,bellend=6.25,h=h);
}

union () {
	translate([0,0,1]) pin(h=21);
	translate([-7.5,-7.5,0]) cube([15,15,2]);
}

/*
translate([18,0,27.25]) rotate([0,180,0]) difference () {
	cylinder(r=7.25, h=27.27);
	translate([0,0,-1]) pinhole();
}
*/

