local META = {}

META.__index = META
META.Error = Material("icon16/cross.png")

function META:__tostring()
	return ("RenderStack [%s]"):format(self.Material)
end

fastlua.Bind(META, "Width", "")
fastlua.Bind(META, "Height", "")

function META:SetSize(w, h)
	self.Width, self.Height  = w, h
end

function META:SetScale(numScale)
	self.Width = self.Width * numScale
	self.Height = self.Height * numScale
end

function META:GetSize()
	return self.Width, self.Height
end

function META:GetMaterial()
	return self.Material
end

function META:SetMaterial(strPath)
	local mat = Material(strPath)
	self.Material = not mat:IsError() and mat or self.Error
end

local SetMat, SetCol, Rect = surface.SetMaterial, surface.SetDrawColor, surface.DrawTexturedRect
local color_white = color_white

function META:Draw(x, y)
	SetCol(color_white)
	SetMat(self.Material)
	Rect(x or 0, y or 0, self:GetWidth(), self:GetHeight())
end

function Metro.Image(strPath)
	local Image = setmetatable({}, META)
	Image.Width = 0
	Image.Height = 0
	Image:SetMaterial(strPath)
	return Image
end