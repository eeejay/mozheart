all: mozlove_toplid_pegs.stl \
	mozlove_toplid_emboss.stl \
	mozlove_body.stl \
	mozlove_logo.stl

clean:
	rm -f *.stl *.dxf *.deps intermediate.eps

%.eps: %.svg
	inkscape -E $@ $<

%.dxf: %.eps
	pstoedit -xscale 100 -yscale 100 -dt -f dxf:-polyaslines $< $@

mozilla.svg heart.svg heart_inset.svg: Makefile

mozlove_toplid_pegs.stl: heart.dxf heart_inset.dxf mozlove.scad Makefile
	 openscad -o mozlove_toplid_pegs.stl -d mozlove_toplid_pegs.deps mozlove_toplid.scad

mozlove_toplid_emboss.stl: mozilla.dxf heart.dxf heart_inset.dxf mozlove.scad Makefile
	 openscad -D pegs=false -o mozlove_toplid_emboss.stl -d mozlove_toplid_emboss.deps mozlove_toplid.scad

mozlove_body.stl: heart.dxf heart_inset.dxf mozlove.scad Makefile
	 openscad -o mozlove_body.stl -d mozlove_body.deps mozlove_body.scad

mozlove_logo.stl: mozilla.dxf mozlove.scad Makefile
	 openscad -o mozlove_logo.stl -d mozlove_logo.deps mozlove_logo.scad

snaps.stl: snaps.scad Makefile
	openscad -o snaps.stl -d snaps.deps snaps.scad
