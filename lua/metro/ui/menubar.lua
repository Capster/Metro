local PANEL = {}

AccessorFunc( PANEL, "m_bBackground", 			"PaintBackground",	FORCE_BOOL )
AccessorFunc( PANEL, "m_bBackground", 			"DrawBackground", 	FORCE_BOOL )
AccessorFunc( PANEL, "m_bIsMenuComponent", 		"IsMenu", 			FORCE_BOOL )

AccessorFunc( PANEL, "m_bDisabled", 	"Disabled" )
AccessorFunc( PANEL, "m_bgColor", 		"BackgroundColor" )


--[[---------------------------------------------------------
	
-----------------------------------------------------------]]
function PANEL:Init()

	self:Dock( TOP )
	self:SetTall( 20 )

	self.Menus = {}

end

function PANEL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, Metro.Colors.MBBackground)
	--draw.RoundedBox(0, 0, h-1, w, 1, Metro.Colors.MBBorder1)
	--draw.RoundedBox(0, 0, h-2, w, 1, Metro.Colors.MBBorder2)
end

function PANEL:GetOpenMenu()

	for k, v in pairs( self.Menus ) do
		if ( v:IsVisible() ) then return v end
	end
	
	return nil

end

function PANEL:AddOrGetMenu( label )

	if ( self.Menus[ label ] ) then return self.Menus[ label ] end
	return self:AddMenu( label )

end

function PANEL:AddMenu( label )

	local m = DermaMenu()
		m:SetDeleteSelf( false )
		m:SetDrawColumn( true )
		m:Hide()
	self.Menus[ label ] = m
	
	local b = self:Add( "MetroButton" )
	b:SetText( label )--:upper() )
	b:Dock( LEFT )
	b:DockMargin( 5, 0, 0, 0 )
	b:SetFont("MetroMiddle")
	b:SetIsMenu( true )
	b:SetDrawBackground( false )
	b:SizeToContentsX( 30 )
	b.Paint = function(self, w, h) 
		if self.Depressed or self.m_bSelected then
			draw.RoundedBox( 0, 0, 0, w, h-2, Metro.Colors.PressedButton )
		elseif self:GetDisabled() then
			draw.RoundedBox( 0, 0, 0, w, h-2, Metro.Colors.DisabledButton )
		elseif self.Hovered then
			draw.RoundedBox( 0, 0, 0, w, h-2, Metro.Colors.LightButton )
		else
			draw.RoundedBox( 0, 0, 0, w, h-2, Metro.Colors.MBBackground )
		end
	end
	
	b.UpdateColours = function(self)
		return self:SetTextStyleColor( Metro.Colors.TextDark )
	end
	
	b.DoClick = function() 
	
		if ( m:IsVisible() ) then
			m:Hide() 
			return 
		end
	
		local x, y = b:LocalToScreen( 0, 0 )
		m:Open( x, y + b:GetTall(), false, b )
		
	end
	
	b.OnCursorEntered = function()
		local opened = self:GetOpenMenu()
		if ( !IsValid( opened ) || opened == m ) then return end
		opened:Hide()
		b:DoClick()
	end
	
	return m

end


Metro.Register( "MetroMenuBar", PANEL, "DPanel" )