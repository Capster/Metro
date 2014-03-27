

PANEL = {}

AccessorFunc( PANEL, "m_bBorder", 			"DrawBorder", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_bDisabled", 		"Disabled", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_FontName", 			"Font" )

function PANEL:Init()

	self:SetContentAlignment( 5 )

	self:SetDrawBorder( true )
	self:SetDrawBackground( true )

	self:SetTall( 22 )
	self:SetMouseInputEnabled( true )
	self:SetKeyboardInputEnabled( true )

	self:SetCursor( "hand" )
	self:SetFont( "DermaDefault" )

end

function PANEL:IsDown()

	return self.Depressed

end

function PANEL:SetImage( img )

	if ( !img ) then
	
		if ( IsValid( self.m_Image ) ) then
			self.m_Image:Remove()
		end
	
		return
	end

	if ( !IsValid( self.m_Image ) ) then
		self.m_Image = vgui.Create( "DImage", self )
	end
	
	self.m_Image:SetImage( img )
	self.m_Image:SizeToContents()
	self:InvalidateLayout()

end

PANEL.SetIcon = PANEL.SetImage

function PANEL:Paint( w, h )

	draw.RoundedBox( 0, 0, 0, w, h, Metro.Colors.BasicButton )

end

function PANEL:UpdateColours( skin )

	if self.Depressed or self.m_bSelected then
		return self:SetTextStyleColor( Metro.Colors.TextBright )
	end
	if self:GetDisabled() then
		return self:SetTextStyleColor( Metro.Colors.TextDark )
	end
	if self.Hovered then
		return self:SetTextStyleColor( Metro.Colors.TextHighlight )
	end

	return self:SetTextStyleColor( Metro.Colors.TextDefault )

end

function PANEL:PerformLayout()
		
	if ( IsValid( self.m_Image ) ) then
			
		self.m_Image:SetPos( 4, (self:GetTall() - self.m_Image:GetTall()) * 0.5 )
		
		self:SetTextInset( self.m_Image:GetWide() + 16, 0 )
		
	end

	DLabel.PerformLayout( self )

end

function PANEL:SetDisabled( bDisabled )

	self.m_bDisabled = bDisabled	
	self:InvalidateLayout()

end

function PANEL:SetConsoleCommand( strName, strArgs )

	self.DoClick = function( self, val ) 
						RunConsoleCommand( strName, strArgs ) 
				   end

end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:SetText( "Example Button" )
		ctrl:SetWide( 200 )
	
	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

function PANEL:OnMousePressed( mousecode )

	return DLabel.OnMousePressed( self, mousecode )

end

function PANEL:OnMouseReleased( mousecode )

	return DLabel.OnMouseReleased( self, mousecode )

end
--[[
function PANEL:SetBackgroundColor( color )

	self.m_colBackgound = color

end
]]

local PANEL = Metro.Register( "MetroButton", PANEL, "DButton" )

PANEL = table.Copy( PANEL )

function PANEL:SetActionFunction( func )

	self.DoClick = function( self, val ) func( self, "Command", 0, 0 ) end

end

Metro.Register( "MetroButton2", PANEL, "DLabel" )