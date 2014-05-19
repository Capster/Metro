local PANEL = {}

fastlua.Bind(PANEL, "Text", "Warning!")

function PANEL:Init()
	self.Disagree = Metro.Create("MetroButton", self)
	self.Disagree:SetText("Disagree")
	self.Disagree:Dock(RIGHT)
	self.Disagree:DockMargin(0, 10, 20, 10)
	self.Disagree.DoClick = function() self:Remove() end
	self.Agree = Metro.Create("MetroButton", self)
	self.Agree:SetText("Agree")
	self.Agree:Dock(RIGHT)
	self.Agree:DockMargin(20, 10, 20, 10)
	
end

function PANEL:SetCallback(callback)
	self.Agree.DoClick = callback
end

function PANEL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, Metro.Colors.WarnBorder)
	draw.RoundedBox(0, 2, 2, w-4, h-4, Metro.Colors.WarnBackground)
	
	draw.SimpleText(self.Text, "MetroSmall", w/2, h/2, Metro.Colors.TextDark, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black )
end

function PANEL:Cooldown()
	self:Remove()
end

Metro.Register( "MetroWarning", PANEL, "DPanel" )
