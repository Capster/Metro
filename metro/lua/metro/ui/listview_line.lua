

local PANEL = {}

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
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

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
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
end

--[[---------------------------------------------------------
   Name: OnSelect
-----------------------------------------------------------]]
function PANEL:OnSelect()

	-- For override
	
end

--[[---------------------------------------------------------
   Name: OnRightClick
-----------------------------------------------------------]]
function PANEL:OnRightClick()

	-- For override
	
end

--[[---------------------------------------------------------
   Name: OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mcode )

	if ( mcode == MOUSE_RIGHT ) then
	
		-- This is probably the expected behaviour..
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

--[[---------------------------------------------------------
   Name: OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnCursorMoved()

	if ( input.IsMouseDown( MOUSE_LEFT ) ) then
		self:GetListView():OnClickLine( self )
	end
	
end

--[[---------------------------------------------------------
   Name: IsLineSelected
-----------------------------------------------------------]]
function PANEL:IsLineSelected()

	return self.m_bSelected

end

--[[---------------------------------------------------------
   Name: SetColumnText
-----------------------------------------------------------]]
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


--[[---------------------------------------------------------
   Name: SetColumnText
-----------------------------------------------------------]]
function PANEL:GetColumnText( i )

	if ( !self.Columns[ i ] ) then return "" end
	
	return self.Columns[ i ].Value

end

PANEL.GetValue = PANEL.GetColumnText

--[[---------------------------------------------------------
   Name: SetColumnText
-----------------------------------------------------------]]
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
