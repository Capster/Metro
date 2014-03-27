Metro.Glyphs = {}
Metro.Glyphs.Registred = {}

function Metro.Glyphs.Draw (name, renderContext, color, x, y, w, h)
	if not Metro.Glyphs.Registred [name] then
		surface.SetDrawColor (color)
		surface.DrawRect (x, y, w, h)
		return
	end
	
	surface.SetDrawColor (color)
	xpcall (Metro.Glyphs.Registred [name], error, renderContext, color, x, y, w, h)
end

function Metro.Glyphs.Register (name, renderer)
	Metro.Glyphs.Registred [name] = renderer
end