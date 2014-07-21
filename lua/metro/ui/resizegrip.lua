local PANEL = {}

function PANEL:Init()
	self:SetSize(16, 16)
	self:SetCursor("sizenwse")
end

function PANEL:Paint(w, h)
end

function PANEL:PerformLayout(w, h)
	local parent = self:GetParent()
	local _w, _h = parent:GetWide(), parent:GetTall()
	self:SetPos(_w - w, _h - h)
end

Metro.Register("MetroResizeGrip", PANEL, "DPanel")