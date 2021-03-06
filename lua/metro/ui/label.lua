

PANEL = {}

AccessorFunc( PANEL, "m_bIsMenuComponent", 		"IsMenu", 			FORCE_BOOL )

AccessorFunc( PANEL, "m_colText", 				"TextColor" )
AccessorFunc( PANEL, "m_colTextStyle", 			"TextStyleColor" )
AccessorFunc( PANEL, "m_FontName", 				"Font" )
AccessorFunc( PANEL, "m_bAutoStretchVertical", 	"AutoStretchVertical", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_bDisabled", 			"Disabled", 				FORCE_BOOL )
AccessorFunc( PANEL, "m_bDoubleClicking", 		"DoubleClickingEnabled", 	FORCE_BOOL )
AccessorFunc( PANEL, "m_bBackground", 			"PaintBackground",			FORCE_BOOL )
AccessorFunc( PANEL, "m_bBackground", 			"DrawBackground", 			FORCE_BOOL )
AccessorFunc( PANEL, "m_bIsToggle", 			"IsToggle", 				FORCE_BOOL )
AccessorFunc( PANEL, "m_bToggle", 				"Toggle", 					FORCE_BOOL )
AccessorFunc( PANEL, "m_bBright", 				"Bright", 					FORCE_BOOL )
AccessorFunc( PANEL, "m_bDark", 				"Dark", 					FORCE_BOOL )
AccessorFunc( PANEL, "m_bHighlight", 			"Highlight", 				FORCE_BOOL )

function PANEL:Init()

	self:SetIsToggle( false )
	self:SetToggle( false )
	self:SetDisabled( false );
	self:SetMouseInputEnabled( false )
	self:SetKeyboardInputEnabled( false )
	self:SetDoubleClickingEnabled( true )

	self:SetTall( 20 )
	
	self:SetPaintBackgroundEnabled( false )
	self:SetPaintBorderEnabled( false )
	
	self:SetFont( "DermaDefault" )	
	
end

function PANEL:SetFont( strFont )

	self.m_FontName = strFont
	self:SetFontInternal( self.m_FontName )	
	self:ApplySchemeSettings()

end

function PANEL:ApplySchemeSettings()

	self:SetFontInternal( self.m_FontName )
	self:UpdateColours( self:GetSkin() );
	
	local col = self.m_colTextStyle
	if ( self.m_colText ) then col = self.m_colText end
	
	self:SetFGColor( col.r, col.g, col.b, col.a )

end

function PANEL:PerformLayout()

	self:ApplySchemeSettings()
	
	if ( self.m_bAutoStretchVertical ) then
		self:SizeToContentsY()
	end

end


PANEL.SetColor = PANEL.SetTextColor

function PANEL:GetColor()

	return self.m_colTextStyle

end

function PANEL:OnCursorEntered()
	
	self:InvalidateLayout( true )
	
end

function PANEL:OnCursorExited()

	self:InvalidateLayout( true )
	
end

function PANEL:OnMousePressed( mousecode )

	if ( self:GetDisabled() ) then return end
	
	if ( mousecode == MOUSE_LEFT && !dragndrop.IsDragging() && self.m_bDoubleClicking ) then
	
		if ( self.LastClickTime && SysTime() - self.LastClickTime < 0.2 ) then
		
			self:DoDoubleClickInternal()
			self:DoDoubleClick()	
			return 
			
		end
		
		self.LastClickTime = SysTime()
	end

	if ( self:IsSelectable() && mousecode == MOUSE_LEFT ) then
	
		if ( input.IsShiftDown() ) then 
			return self:StartBoxSelection()
		end
		
	end
	
	self:MouseCapture( true )
	self.Depressed = true
	self:OnDepressed();
	self:InvalidateLayout();
	
	self:DragMousePress( mousecode );

end

function PANEL:OnDepressed()

end

function PANEL:OnMouseReleased( mousecode )

	self:MouseCapture( false )
	
	if ( self:GetDisabled() ) then return end
	if ( !self.Depressed ) then return end
	
	self.Depressed = nil
	self:OnReleased();
	self:InvalidateLayout();

	if ( self:DragMouseRelease( mousecode ) ) then
		return
	end
	
	if ( self:IsSelectable() && mousecode == MOUSE_LEFT ) then
			
		local canvas = self:GetSelectionCanvas()
		if ( canvas ) then
			canvas:UnselectAll()
		end
		
	end
	
	if ( !self.Hovered ) then return end

	self.Depressed = true

	if ( mousecode == MOUSE_RIGHT ) then
		self:DoRightClick()
	end
	
	if ( mousecode == MOUSE_LEFT ) then	
		self:DoClickInternal()
		self:DoClick()
	end

	if ( mousecode == MOUSE_MIDDLE ) then
		self:DoMiddleClick()
	end

	self.Depressed = nil

end

function PANEL:OnReleased()

end

function PANEL:DoRightClick()

end

function PANEL:DoMiddleClick()

end

function PANEL:DoClick()

	self:Toggle()

end

function PANEL:Toggle()

	if ( !self:GetIsToggle() ) then return end
	
	self.m_bToggle = !self.m_bToggle
	self:OnToggled( self.m_bToggle )

end

function PANEL:OnToggled( bool )

end

function PANEL:DoClickInternal()

end

function PANEL:DoDoubleClick()

end

function PANEL:DoDoubleClickInternal()
	
end

function PANEL:UpdateColours( )

	if self.m_bBright then
		return self:SetTextStyleColor( Metro.Colors.TextBright )
	end
	if self.m_bDark then
		return self:SetTextStyleColor( Metro.Colors.TextDark )
	end
	if self.m_bHighlight then
		return self:SetTextStyleColor( Metro.Colors.TextHighlight )
	end

	return self:SetTextStyleColor( Metro.Colors.TextDefault )

end

Metro.Register( "MetroLabel", PANEL, "Label" )

function Metro.Label( strText, parent )

	local lbl = Metro.Create( "MetroLabel", parent )
	lbl:SetText( strText )
	
	return lbl

end
