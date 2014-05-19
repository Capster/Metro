local PANEL = {}

function PANEL:Init()
	self:SetTextInset( 32, 0 )
	self:SetContentAlignment( 4 )
end

function PANEL:Paint( w, h )
	local w = self:GetTextSize() 
	
	if self.Depressed or self.m_bSelected then
		draw.RoundedBox(0, 38, 0, w+6, h, Metro.Colors.LVLineSelectedB)
		draw.RoundedBox(0, 39, 1, w+4, h-2, Metro.Colors.LVLineSelected)
	elseif self.Hovered	then
		draw.RoundedBox(0, 38, 0, w+6, h, Metro.Colors.LVLineHoveredB)
		draw.RoundedBox(0, 39, 1, w+4, h-2, Metro.Colors.LVLineHovered)
	else	
		-- Nothing...
	end
	return false
end

Metro.Register( "MetroTree_Node_Button", PANEL, "MetroButton" )