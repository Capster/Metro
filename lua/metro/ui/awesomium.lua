PANEL = {}

AccessorFunc( PANEL, "m_bScrollbars", 			"Scrollbars", 		FORCE_BOOL )
fastlua.Bind(PANEL, "AllowLua", false)

function PANEL:Init()
	
	self:SetScrollbars( true )
	self:SetAllowLua( false )

	self.JS = {}
	self.Callbacks = {}
	self:AddFunction( "console", "log", function( param ) self:ConsoleMessage( param ) end )
	
end

function PANEL:Think()

	if self.JS and not self:IsLoading() then

		for k, v in pairs( self.JS ) do

			self:RunJavascript( v )

		end

		self.JS = nil

	end

end

function PANEL:Paint(w, h)

	if self:IsLoading() then
		return true
	end

end

function PANEL:PaintOver(w, h)

	--[[if ValidPanel(self.Warning) then
		draw.RoundedBox(0, 0, 0, w, h, Color(50,50,50,140))
	end]]

end

function PANEL:QueueJavascript( js )

	if not self.JS and not self:IsLoading() then
		return self:RunJavascript( js )
	end

	self.JS = self.JS or {}

	table.insert( self.JS, js )
	self:Think()

end

function PANEL:Call( js )
	self:QueueJavascript( js )
end

function PANEL:ConsoleMessage( msg )

	if not isstring( msg ) then msg = "*js variable*" end

	if self.m_bAllowLua and msg:StartWith( "RUNLUA:" ) then
	
		local strLua = msg:sub( 8 )

		SELF = self
		RunString( strLua )
		SELF = nil
		return

	end

	MsgC( Color( 255, 160, 255 ), "[HTML] " )
	MsgC( Color( 255, 255, 255 ), msg, "\n" )	
	if GPad and GPad.JS then
		GPad.JS.Log(msg)
	end

end

function PANEL:OnCallback( obj, func, args )

	local f = self.Callbacks[ obj .. "." .. func ]

	if f then
		return f( unpack( args ) )
	end

end

function PANEL:AddFunction( obj, funcname, func )

	if not self.Callbacks[ obj ] then
		self:NewObject( obj )
		self.Callbacks[ obj ] = true
	end

	self:NewObjectCallback( obj, funcname )

	self.Callbacks[ obj .. "." .. funcname ] = func

end

function PANEL:CreateAlert( str, callback )

	if ValidPanel(self.Warning) then self.Warning:Remove() end
	self.Warning = Metro.Create("MetroWarning", self)
	self.Warning:SetText(str)
	self.Warning:Dock(TOP)
	self.Warning:DockMargin(20,0,40,10)
	self.Warning:SetTall(50)
	self.Warning:SetCallback(function()
		
		m_bAllowLua = true
		self.Warning:Remove()
		
	end)
	
end


Metro.Register( "MetroHTML", PANEL, "Awesomium" )
