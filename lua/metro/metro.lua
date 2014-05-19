----------------------------------------------------------------------------
--## Metro - a VGUI libraty in GLua for Garry's Mod
-- 
-- Copyright (C) 2014 Capster <***>
--
----------------------------------------------------------------------------
--## USAGE
-- 	ToDo...
--
--## TODOs:
--	- Static debug VGUI functions
--	- Image Cache
--
-- @module metro

Metro = {}

Metro.Frames = {}

surface.CreateFont("MetroSmall", {font =  "Default", size = 13, antialias = true, outline = false, weight = 540, })

function Metro.Register(className, classTable, baseClassName)

	return vgui.Register (className, classTable, baseClassName)
	
end

function Metro.Create( className, parentClassName )

	local self = vgui.Create( className, parentClassName )
	table.insert(Metro.Frames, self)
	return self
	
end

function Metro.CreateFrame(w, h)

	local w, h = w or 250, h or 250
	
	local frame = Metro.Create("MetroFrame")
		frame:SetSize(w, h)
		frame:Center()
		frame:MakePopup()
	return frame
	
end

local matBlurScreen = Material( "pp/blurscreen" )


function Metro.DrawBackgroundBlur( panel, starttime )

	local Fraction = 1

	if ( starttime ) then
		Fraction = math.Clamp( (SysTime() - starttime) / 1, 0, 1 )
	end

	local x, y = panel:LocalToScreen( 0, 0 )

	DisableClipping( true )
	
	surface.SetMaterial( matBlurScreen )	
	surface.SetDrawColor( 255, 255, 255, 255 )
		
	for i=0.33, 1, 0.33 do
		matBlurScreen:SetFloat( "$blur", Fraction * 5 * i )
		matBlurScreen:Recompute()
		if ( render ) then render.UpdateScreenEffectTexture() end -- Todo: Make this available to menu Lua
		surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
	end
	
	surface.SetDrawColor( 10, 10, 10, 200 * Fraction )
	surface.DrawRect( x * -1, y * -1, ScrW(), ScrH() )
	
	DisableClipping( false )

end

function Metro.IncludeDir(directoryName)
	local metro_path = debug.getinfo(1).short_src:gsub("\\", "/"):GetPathFromFilename()
	for k, v in pairs(file.Find(metro_path.."/"..directoryName.."/*.lua", "GAME")) do
		include(directoryName.."/"..v)
	end
	
end