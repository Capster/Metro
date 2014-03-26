local PANEL = {}

function PANEL:Init ()
	self:SetSize (24, 24)	
	self:SetCursor ("sizenwse")
end

function PANEL:Paint (w, h)
	local padding = 3
	local dotSize = math.min ((math.min (w, h) - padding * 2) / 5, 3)
	dotSize = math.floor (dotSize + 0.5) -- round dotSize
	
	local x = w - padding - dotSize * 5
	draw.RoundedBox (2, x, h - padding - dotSize, dotSize, dotSize, Metro.Colors.GripColor)
	x = w - padding - dotSize * 3
	draw.RoundedBox (2, x, h - padding - dotSize * 3, dotSize, dotSize, Metro.Colors.GripColor)
	draw.RoundedBox (2, x, h - padding - dotSize, dotSize, dotSize, Metro.Colors.GripColor)
	x = w - padding - dotSize
	draw.RoundedBox (2, x, h - padding - dotSize * 5, dotSize, dotSize, Metro.Colors.GripColor)
	draw.RoundedBox (2, x, h - padding - dotSize * 3, dotSize, dotSize, Metro.Colors.GripColor)
	draw.RoundedBox (2, x, h - padding - dotSize, dotSize, dotSize, Metro.Colors.GripColor)
end

function PANEL:PerformLayout ()
	self:SetPos (self:GetParent ():GetWide () - self:GetWide (), self:GetParent ():GetTall () - self:GetTall ())
end

Metro.Register("MetroResizeGrip", PANEL, "DPanel")