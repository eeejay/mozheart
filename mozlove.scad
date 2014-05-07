use <snaps.scad>

module _pegs(r=0.75) {
	translate([-19,0,0]) cylinder(h=3,r=r, $fn=10);
	translate([-19,-4,0]) cylinder(h=3,r=r, $fn=10);
	translate([-10.75,-3,0]) cylinder(h=3,r=r, $fn=10);
	translate([-6,-0.5,0]) cylinder(h=3,r=r, $fn=10);
	translate([1.5,1.5,0]) cylinder(h=3,r=r, $fn=10);
	translate([-2.5,-5,0]) cylinder(h=3,r=r, $fn=10);
	translate([5.4,-4.5,0]) cylinder(h=3,r=r, $fn=10);
	translate([5.4,1.5,0]) cylinder(h=3,r=r, $fn=10);
	translate([5.3,5.1,0]) cylinder(h=3,r=r, $fn=10);
	translate([9.5,-4.5,0]) cylinder(h=3,r=r, $fn=10);
	translate([9.5,4.5,0]) cylinder(h=3,r=r, $fn=10);
	translate([14.2,-4.5,0]) cylinder(h=3,r=r, $fn=10);
	translate([14.2,4.5,0]) cylinder(h=3,r=r, $fn=10);
	translate([18.75,-4.5,0]) cylinder(h=3,r=r, $fn=10);
	translate([23,1,0]) cylinder(h=3,r=r, $fn=10);
}

module mozilla(h=4, pegs=true) {
	width = 50;
	height = 13;
	union () {
		color("white") translate([width/-2,height/-2,0]) linear_extrude(height = h, convexity = 10)
		resize(newsize=[width,height,0])
                scale(0.1)
		import (file = "mozilla.dxf");
		if (pegs) {
			translate([0,0,-1])  _pegs();
		}
	}
}

module heart(width=70.25, height=58.25, depth=15) {
	linear_extrude(height = depth, convexity = 10)
	translate([width/-2, height/-2, 0]) resize(newsize=[width,height,0])
        scale(0.01)
	import (file = "heart.dxf");
}

module heart_inset(width=65.775, height=53.581, depth=15) {
	linear_extrude(height = depth, convexity = 10)
	translate([width/-2, height/-2, 0]) resize(newsize=[width,height,0])
        scale(0.01)
	import (file = "heart_inset.dxf");
}

module top_lid(pegs=true) {
	color ("red") difference () {
		union () {
			difference () {
				heart(depth=8);
				translate([0, 0, -0.5]) heart_inset(depth=6.5);
				if (pegs) {
					translate([0, 7.5, 7]) _pegs(r=1.1);
				} else {
					translate([0, 7.5, 7]) mozilla(pegs=false);
				}
			}
			//translate([0,-21.5,0]) pinplace();
			translate([-3.5, 13.5, 0]) cube([7,7,7.5]);
			translate([0,-20,2]) rotate([0,180,0]) pin(h=21);
			translate([0,-20,0]) cylinder(r=7.25, h=7.5);
		}
		translate([-2.75,14.25,-0.5]) cube([5.5,5.5,6]);
	}
}

module box_body() {
	color ("red") difference () {
		union () {
			difference () {
				heart(depth=30);
				translate([0, 0, 3]) heart_inset(depth=30);
			}
			translate([-3.5, 13.5, 1]) cube([7,7,29]);
			translate([0,-20,1]) cylinder(r=7.25, h=29);

		}
		translate([-2.75,14.25,24.5]) cube([5.5,5.5,6]);
		translate([0, -20, 31]) rotate([0,180,0]) pinhole();
	}
}

box_body();
translate([0,0,30]) top_lid();
translate([0, 7.5, 38]) mozilla(height=3);
