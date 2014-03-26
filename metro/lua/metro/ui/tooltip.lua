local tooltip_delay = CreateClientConVar( "tooltip_delay", "0.5", true, false ) 

PANEL = {}


function PANEL:Init()

	self:SetDrawOnTop( true )
	self.DeleteContentsOnClose = false
	self:SetText( "" )
	self:SetFont( "MetroSmall" )
	self.m_colText = Metro.Colors.TextBright
	--self:SetContents(self:GetParent())
	--self:DrawArrow( 0, 0 )
end

function PANEL:UpdateColours( skin )

	return self:SetTextStyleColor( skin.Colours.TooltipText )

end

function PANEL:SetContents( panel, bDelete )

	self:SetParent( self )

	self.Contents = panel
	self.DeleteContentsOnClose = bDelete or false	
	self.Contents:SizeToContents()
	self:InvalidateLayout( true )
	
	self.Contents:SetVisible( false )

end

function PANEL:PerformLayout()

	if ( self.Contents ) then
	
		self:SetWide( self.Contents:GetWide() + 20 )
		self:SetTall( self.Contents:GetTall() + 20 )
		self.Contents:SetPos( 10, 10 )
		
	else
	
		local w, h = self:GetContentSize()
		self:SetSize( w + 20, h + 20 )
		self:SetContentAlignment( 5 )
	
	end

end

local Mat = Material( "vgui/arrow" )

function PANEL:DrawArrow( x, y )

	self.Contents:SetVisible( true )
	
	surface.SetMaterial( Mat )	
	surface.DrawTexturedRect( self.ArrowPosX+x, self.ArrowPosY+y, self.ArrowWide, self.ArrowTall )

end

function PANEL:PositionTooltip()

	if ( !IsValid( self.TargetPanel ) ) then
		self:Remove()
		return;
	end

	self:PerformLayout()
	
	local x, y		= input.GetCursorPos()
	local w, h		= self:GetSize()
	
	local lx, ly	= self.TargetPanel:LocalToScreen( 0, 0 )
	
	y = y - 50
	
	y = math.min( y, ly - h * 1.5 )
	if ( y < 2 ) then y = 2 end
	
	self:SetPos( math.Clamp( x - w * 0.5, 0, ScrW( ) - self:GetWide( ) ), math.Clamp( y, 0, ScrH( ) - self:GetTall( ) ) )

end

function PANEL:Paint( w, h )

	self:PositionTooltip()
	draw.RoundedBox(0, 0, 0, w, h, Metro.Colors.ToolTipBorder)
	draw.RoundedBox(0, 1, 1, w-2, h-2, Metro.Colors.ToolTipInside)

end

function PANEL:OpenForPanel( panel )
	
	self.TargetPanel = panel
	self:PositionTooltip();	
	
	if ( tooltip_delay:GetFloat() > 0 ) then
	
		self:SetVisible( false )
		timer.Simple( tooltip_delay:GetFloat(), function() 
		
													if ( !IsValid( self ) ) then return end
													if ( !IsValid( panel ) ) then return end

													self:PositionTooltip();	
													self:SetVisible( true )
												
												end )
	end

end

function PANEL:Close()

	if ( !self.DeleteContentsOnClose && self.Contents ) then
	
		self.Contents:SetVisible( false )
		self.Contents:SetParent( nil )
	
	end
	
	self:Remove()

end


Metro.Register( "MetroTooltip", PANEL, "MetroLabel" )
