PANEL = {}
AccessorFunc( PANEL, "m_bStretchToFit", "StretchToFit" )

function PANEL:Init()

	self:SetDrawBackground( false )
	self:SetDrawBorder( false )
	self:SetStretchToFit( true )
	
	self.m_Image = Metro.Create( "DImage", self )
	
	self:SetText( "" )
	
	self:SetColor( color_white )

end

function PANEL:Think()
	--DButton.Think()
	
	if self.activeCallback then
		self.activeCallback(self)
	end

end

function PANEL:SetImageVisible( bBool )

	self.m_Image:SetVisible( bBool )

end

function PANEL:SetImage( strImage, strBackup )

	self.m_Image:SetImage( strImage, strBackup )

end

PANEL.SetIcon = PANEL.SetImage

function PANEL:SetColor( col )

	self.m_Image:SetImageColor( col )
	self.ImageColor = col

end

function PANEL:GetImage()

	return self.m_Image:GetImage()

end

function PANEL:SetKeepAspect( bKeep )

	self.m_Image:SetKeepAspect( bKeep )

end

PANEL.SetMaterial = PANEL.SetImage

function PANEL:SizeToContents( )

	self.m_Image:SizeToContents()
	self:SetSize( self.m_Image:GetWide(), self.m_Image:GetTall() )

end

function PANEL:OnMousePressed( mousecode )

	DButton.OnMousePressed( self, mousecode )

	
	if ( self.m_bStretchToFit ) then
			
		self.m_Image:SetPos( 2, 2 )
		self.m_Image:SetSize( self:GetWide() - 4, self:GetTall() - 4 )
		
	else
	
		self.m_Image:SizeToContents()
		self.m_Image:SetSize( self.m_Image:GetWide() * 0.8, self.m_Image:GetTall() * 0.8 )
		self.m_Image:Center()
		
	end

end

function PANEL:OnMouseReleased( mousecode )

	DButton.OnMouseReleased( self, mousecode )

	if ( self.m_bStretchToFit ) then
			
		self.m_Image:SetPos( 0, 0 )
		self.m_Image:SetSize( self:GetSize() )
		
	else
	
		self.m_Image:SizeToContents()
		self.m_Image:Center()
		
	end

end

function PANEL:PerformLayout()

	if ( self.m_bStretchToFit ) then
			
		self.m_Image:SetPos( 0, 0 )
		self.m_Image:SetSize( self:GetSize() )
		
	else
	
		self.m_Image:SizeToContents()
		self.m_Image:Center()
		
	end

end

function PANEL:SetDisabled( bDisabled )

	DButton.SetDisabled( self, bDisabled )

	if ( bDisabled ) then
		self.m_Image:SetAlpha( self.ImageColor.a * 0.4 ) 
	else
		self.m_Image:SetAlpha( self.ImageColor.a ) 
	end

end

function PANEL:GetDisabled()

	return DButton.GetDisabled( self )

end

function PANEL:SetOnViewMaterial( MatName, Backup )

	self.m_Image:SetOnViewMaterial( MatName, Backup )

end

Metro.Register( "MetroImageButton", PANEL, "DButton" )