all: mozheart_toplid_pegs.stl \
	mozheart_toplid_emboss.stl \
	mozheart_body.stl \
	mozheart_logo.stl

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

mozheart_toplid_pegs.stl: heart.dxf heart_inset.dxf mozheart.scad
	 openscad -o mozheart_toplid_pegs.stl -d mozheart_toplid_pegs.deps mozheart_toplid.scad

mozheart_toplid_emboss.stl: mozilla.dxf heart.dxf heart_inset.dxf mozheart.scad
	 openscad -D pegs=false -o mozheart_toplid_emboss.stl -d mozheart_toplid_emboss.deps mozheart_toplid.scad

mozheart_body.stl: heart.dxf heart_inset.dxf mozheart.scad
	 openscad -o mozheart_body.stl -d mozheart_body.deps mozheart_body.scad

mozheart_logo.stl: mozilla.dxf mozheart.scad
	 openscad -o mozheart_logo.stl -d mozheart_logo.deps mozheart_logo.scad

snaps.stl: snaps.scad
	openscad -o snaps.stl -d snaps.deps snaps.scad