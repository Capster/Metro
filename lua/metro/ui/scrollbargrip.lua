local PANEL = {}

function PANEL:Init()
end

function PANEL:OnMousePressed()

	self:GetParent():Grip( 1 )

end

function PANEL:Paint( w, h )
	
	draw.RoundedBox(0, 0, 0, w, h, Metro.Colors.SBGrip)
	return true
	
end

Metro.Register( "MetroScrollBarGrip", PANEL, "DPanel" )