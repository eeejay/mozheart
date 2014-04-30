all: mozlove_toplid_pegs.stl \
	mozlove_toplid_emboss.stl \
	mozlove_body.stl \
	mozlove_logo.stl

clean:
	rm -f *.stl *.dxf *.deps intermediate.eps

mozilla.dxf: mozilla.svg
	@inkscape -E intermediate.eps mozilla.svg
	@pstoedit -dt -f dxf:-polyaslines intermediate.eps mozilla.dxf
	@echo "Generated mozilla.dxf"

heart.dxf: heart.svg
	@inkscape -E intermediate.eps heart.svg
	@pstoedit -dt -f dxf:-polyaslines intermediate.eps heart.dxf
	@echo "Generated heart.dxf"

heart_inset.dxf: heart_inset.svg
	@inkscape -E intermediate.eps heart_inset.svg
	@pstoedit -dt -f dxf:-polyaslines intermediate.eps heart_inset.dxf
	@echo "Generated heart_inset.dxf"

mozlove_toplid_pegs.stl: heart.dxf heart_inset.dxf mozlove.scad
	 openscad -o mozlove_toplid_pegs.stl -d mozlove_toplid_pegs.deps mozlove_toplid.scad

mozlove_toplid_emboss.stl: mozilla.dxf heart.dxf heart_inset.dxf mozlove.scad
	 openscad -D pegs=false -o mozlove_toplid_emboss.stl -d mozlove_toplid_emboss.deps mozlove_toplid.scad

mozlove_body.stl: heart.dxf heart_inset.dxf mozlove.scad
	 openscad -o mozlove_body.stl -d mozlove_body.deps mozlove_body.scad

mozlove_logo.stl: mozilla.dxf mozlove.scad
	 openscad -o mozlove_logo.stl -d mozlove_logo.deps mozlove_logo.scad

snaps.stl: snaps.scad
	openscad -o snaps.stl -d snaps.deps snaps.scad