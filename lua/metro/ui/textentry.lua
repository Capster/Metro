PANEL = {}

local strAllowedNumericCharacters = "1234567890.-"
local strAllowedCalcCharacters = "1234567890.-+*/^()"

AccessorFunc( PANEL, "m_bAllowEnter", 		"EnterAllowed", FORCE_BOOL )
AccessorFunc( PANEL, "m_bUpdateOnType", 	"UpdateOnType", FORCE_BOOL )	-- Update the convar as we type
AccessorFunc( PANEL, "m_bNumeric", 			"Numeric", FORCE_BOOL )
AccessorFunc( PANEL, "m_bHistory", 			"HistoryEnabled", FORCE_BOOL )
AccessorFunc( PANEL, "m_bDisableTabbing", 	"TabbingDisabled", 	FORCE_BOOL )
AccessorFunc( PANEL, "m_FontName", 			"Font" )
AccessorFunc( PANEL, "m_bBorder", 			"DrawBorder" )
AccessorFunc( PANEL, "m_bBackground", 		"DrawBackground" )

AccessorFunc( PANEL, "m_colText", 			"TextColor" )
AccessorFunc( PANEL, "m_colHighlight", 		"HighlightColor" )
AccessorFunc( PANEL, "m_colCursor", 		"CursorColor" )

AccessorFunc( PANEL, "m_bDisabled", 		"Disabled" )




Derma_Install_Convar_Functions( PANEL )

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Init()

	self:SetHistoryEnabled( false )
	self.History = {}
	self.HistoryPos = 0
	
	self:SetPaintBorderEnabled( false )
	self:SetPaintBackgroundEnabled( false )

	self:SetDrawBackground( true )
	self:SetEnterAllowed( true )
	self:SetUpdateOnType( false )
	self:SetNumeric( false )
	self:SetAllowNonAsciiCharacters( true )
		
	self:SetTall( 20 )
	
	self.m_bLoseFocusOnClickAway = true
	
	self:SetCursor( "beam" )
	
	derma.SkinHook( "Scheme", "TextEntry", self )

	self:SetFont( "DermaDefault" )

end

function PANEL:IsEditing()
	return self == vgui.GetKeyboardFocus()
end

function PANEL:OnKeyCodeTyped( code )

	self:OnKeyCode( code )

	if ( code == KEY_ENTER && !self:IsMultiline() && self:GetEnterAllowed() ) then
	
		if ( IsValid( self.Menu ) ) then
			self.Menu:Remove()
		end
	
		self:FocusNext()
		self:OnEnter()
		self.HistoryPos = 0
		
	end
	
	if ( self.m_bHistory || IsValid( self.Menu ) ) then
	
		if ( code == KEY_UP ) then
			self.HistoryPos = self.HistoryPos - 1;
			self:UpdateFromHistory()
		end
		
		if ( code == KEY_DOWN || code == KEY_TAB ) then	
			self.HistoryPos = self.HistoryPos + 1;
			self:UpdateFromHistory()
		end
	
	end
	
end

function PANEL:OnKeyCode( code )
	
end

function PANEL:ApplySchemeSettings()

	self:SetFontInternal( self.m_FontName )

end

function PANEL:UpdateFromHistory()

	if ( IsValid( self.Menu ) ) then
		return self:UpdateFromMenu()
	end


	local pos = self.HistoryPos
	if ( pos < 0 ) then pos = #self.History end
	if ( pos > #self.History ) then pos = 0 end
	
	local text = self.History[ pos ]
	if ( !text ) then text = "" end
	
	self:SetText( text )
	self:SetCaretPos( text:len() )
	
	self.HistoryPos = pos

end

function PANEL:UpdateFromMenu()

	local pos = self.HistoryPos
	local num = self.Menu:ChildCount()
	
	self.Menu:ClearHighlights()

	if ( pos < 0 ) then pos = num end
	if ( pos > num ) then pos = 0 end
	
	local item = self.Menu:GetChild( pos )
	if ( !item ) then
		self:SetText( "" )
		self.HistoryPos = pos
	return end
	
	self.Menu:HighlightItem( item )
	
	local txt = item:GetText()
	
	self:SetText( txt )
	self:SetCaretPos( txt:len() )
	
	self.HistoryPos = pos

end

function PANEL:OnTextChanged()
	
	self.HistoryPos = 0
	
	if ( self:GetUpdateOnType() ) then
		self:UpdateConvarValue()
		self:OnValueChange( self:GetText() )
	end
	
	if ( IsValid( self.Menu ) ) then
		self.Menu:Remove()
	end
	
	local tab = self:GetAutoComplete( self:GetText() )
	if ( tab ) then
		self:OpenAutoComplete( tab )
	end
	
	self:OnChange()
	
end

function PANEL:OnChange()

	
		
end

function PANEL:OpenAutoComplete( tab )

	if ( !tab ) then return end
	if ( #tab == 0 ) then return end
	
	self.Menu = DermaMenu()
	
		for k, v in pairs( tab ) do
			
			self.Menu:AddOption( v, function() self:SetText( v ) self:SetCaretPos( v:len() ) self:RequestFocus() end )		

		end
	
	local x, y = self:LocalToScreen( 0, self:GetTall() )
	self.Menu:SetMinimumWidth( self:GetWide() )
	self.Menu:Open( x, y, true, self )
	self.Menu:SetPos( x, y )
	self.Menu:SetMaxHeight( (ScrH() - y) - 10 )

end

function PANEL:Think()

	self:ConVarStringThink()

end

function PANEL:OnEnter()

	self:UpdateConvarValue()
	self:OnValueChange( self:GetText() )

end

function PANEL:UpdateConvarValue()

	self:ConVarChanged( self:GetValue() )

end

function PANEL:Paint( w, h )
	
	draw.RoundedBox(0, 0, 0, w, h, Metro.Colors.TextEBorder)
	if ( self.m_bBackground ) then
	
		if ( self:GetDisabled() ) then
			draw.RoundedBox(0, 1, 1, w-2, h-2, Metro.Colors.TextEInsideDis)
		elseif ( self:HasFocus() ) then
			draw.RoundedBox(0, 1, 1, w-2, h-2, Metro.Colors.TextEInsideFoc)
		else
			draw.RoundedBox(0, 1, 1, w-2, h-2, Metro.Colors.TextEInside)
		end
	
	end
	
	self:DrawTextEntryText( self.m_colText, self.m_colHighlight, self.m_colCursor )
	
	return false

end

function PANEL:PerformLayout()

	derma.SkinHook( "Layout", "TextEntry", self )

end

function PANEL:SetValue( strValue )

	if ( vgui.GetKeyboardFocus() == self ) then return end

	local CaretPos = self:GetCaretPos()

	self:SetText( strValue )
	self:OnValueChange( strValue )
	
	self:SetCaretPos( CaretPos )

end

function PANEL:OnValueChange( strValue )

end

function PANEL:CheckNumeric( strValue )

	if ( !self:GetNumeric() ) then return false end
	
	if ( !string.find ( strAllowedNumericCharacters, strValue ) ) then
	
		return true
		
	end

	return false	

end

function PANEL:AllowInput( strValue )

	if ( self:CheckNumeric( strValue ) ) then return true end

end

function PANEL:SetEditable( b )
	
	self:SetKeyboardInputEnabled( b )
	self:SetMouseInputEnabled( b )
	
end

function PANEL:OnGetFocus()

	hook.Run( "OnTextEntryGetFocus", self )
	
end

function PANEL:OnLoseFocus()
	
	self:UpdateConvarValue()
	
	hook.Call( "OnTextEntryLoseFocus", nil, self )
	
end

function PANEL:OnMousePressed( mcode )
	
	self:OnGetFocus()
	
end

function PANEL:AddHistory( txt )
	
	if ( !txt || txt == "" ) then return; end
	
	table.RemoveByValue( self.History, txt )	
	table.insert( self.History, txt )
	
end

function PANEL:GetAutoComplete( txt )
end

function PANEL:GetInt()

	return math.floor( tonumber( self:GetText() ) + 0.5 )

end

function PANEL:GetFloat()

	return tonumber( self:GetText() )

end


Metro.Register( "MetroTextEntry", PANEL, "TextEntry" )