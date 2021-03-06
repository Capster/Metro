local PANEL = {}

function PANEL:Init()

	self:SetTextInset( 5, 0 )

end

function PANEL:UpdateColours( skin )

	if self:GetParent():IsLineSelected() then
		return self:SetTextStyleColor( Metro.Colors.TextHighlight )
	end
	
	return self:SetTextStyleColor( Metro.Colors.TextDefault )

end
Metro.Register( "MetroListViewLabel", PANEL, "MetroLabel" )

local PANEL = {}

Derma_Hook( PANEL, "ApplySchemeSettings", "Scheme", "ListViewLine" )
Derma_Hook( PANEL, "PerformLayout", "Layout", "ListViewLine" )

AccessorFunc( PANEL, "m_iID", 				"ID" )
AccessorFunc( PANEL, "m_pListView", 		"ListView" )
AccessorFunc( PANEL, "m_bAlt", 				"AltLine" )

fastlua.Bind(PANEL, "Icon", nil)

function PANEL:SetIcon(icon)
	if not self.Icon then
		self:SetColumnText( 1, "      "..self:GetColumnText(1) )
	end
	self.Icon = Metro.ImageCache():GetImage(icon)
	self.Icon:SetSize (16, 16)
end

function PANEL:Init()

	self:SetSelectable( true )
	self:SetMouseInputEnabled( true )
	
	self.Columns = {}
end

function PANEL:Paint(w, h)
	
	local x = 0
	for k, Column in pairs( self.Columns ) do
	
		local w = self:GetParent():GetParent():ColumnWidth( k )
		draw.RoundedBox(0, x, 0, 1, h, Metro.Colors.LVLineCBorder)
		x = x + w
	
	end	

	if self:IsSelected() then
	
		draw.RoundedBox(0, 0, 0, w, h, Metro.Colors.LVLineSelectedB)
		draw.RoundedBox(0, 1, 1, w-2, h-2, Metro.Colors.LVLineSelected)
		
	elseif self.Hovered then

		draw.RoundedBox(0, 0, 0, w, h, Metro.Colors.LVLineHoveredB)
		draw.RoundedBox(0, 1, 1, w-2, h-2, Metro.Colors.LVLineHovered)
	 
	elseif self.m_bAlt then

		--draw.RoundedBox(0, 0, 0, w, h, Metro.Colors.LVLineHovered)
	         
	end
	
	if self.Icon then
		local spacing = (self:GetTall () - 16) * 0.5
		self.Icon:Draw(spacing + 1, spacing)
	end
end

function PANEL:OnSelect()

	
end

function PANEL:OnRightClick()

	
end

function PANEL:OnMouseReleased( mcode )

	if ( mcode == MOUSE_RIGHT ) then
	
		if ( !self:IsLineSelected() ) then
		
			self:GetListView():OnClickLine( self, true )
			self:OnSelect()

		end
		
		self:GetListView():OnRowRightClick( self:GetID(), self )
		self:OnRightClick()
		
		return
		
	end

	self:GetListView():OnClickLine( self, true )
	self:OnSelect()
	
end

function PANEL:OnCursorMoved()

	if ( input.IsMouseDown( MOUSE_LEFT ) ) then
		self:GetListView():OnClickLine( self )
	end
	
end

function PANEL:IsLineSelected()

	return self.m_bSelected

end

function PANEL:SetColumnText( i, strText )

	if ( type( strText ) == "Panel" ) then
	
		if ( IsValid( self.Columns[ i ] ) ) then self.Columns[ i ]:Remove() end
	
		strText:SetParent( self )
		self.Columns[ i ] = strText
		self.Columns[ i ].Value = strText
		return
		
	end

	if ( !IsValid( self.Columns[ i ] ) ) then
	
		self.Columns[ i ] = Metro.Create( "MetroListViewLabel", self )
		self.Columns[ i ]:SetMouseInputEnabled( false )
		
	end
	
	self.Columns[ i ]:SetText( tostring( strText ) )
	self.Columns[ i ].Value = strText
	return self.Columns[ i ]

end

PANEL.SetValue = PANEL.SetColumnText

function PANEL:GetColumnText( i )

	if ( !self.Columns[ i ] ) then return "" end
	
	return self.Columns[ i ].Value

end

PANEL.GetValue = PANEL.GetColumnText

function PANEL:DataLayout( ListView )

	self:ApplySchemeSettings()

	local height = self:GetTall()
	
	local x = 0
	for k, Column in pairs( self.Columns ) do
	
		local w = ListView:ColumnWidth( k )
		Column:SetPos( x, 0 )
		Column:SetSize( w, height )
		x = x + w
	
	end	

end

Metro.Register( "MetroListViewLine", PANEL, "Panel" )
