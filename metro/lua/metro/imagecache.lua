local META = {}

META.__index = META
META.Type = "CacheStream"
META.Error = Material("icon16/cross.png")

function META:__tostring()
	return ("CacheStream [%s]"):format(self.Material)
end

fastlua.Bind(META, "Width", "")
fastlua.Bind(META, "Height", "")

function META:SetSize (width, height)
	self.Width  = width
	self.Height = height
end

function META:GetSize ()
	return self.Width, self.Height
end

function META:GetMaterial()
	return not self.Material:IsError() and self.Material or self.Error
end

function META:SetMaterial(image)
	self.Material = Material(image)
end

local SetMat, SetCol, Rect = surface.SetMaterial, surface.SetDrawColor, surface.DrawTexturedRect

function META:Draw (x, y, r, g, b, a)
	SetMat(self:GetMaterial())
	SetCol(r or 255, g or 255, b or 255, a or 255)
	Rect(x or 0, y or 0, self:GetWidth() or 0, self:GetHeight() or 0)
end

function Metro.CacheEntry(image)
	local cache = setmetatable({}, META)
	cache:SetMaterial(image)
	return cache
end

--
local META = {}

META.__index = META
META.Type = "ImageCache"


function META:__tostring()
	return ("ImageCache [%s]"):format(self.image)
end

function META:GetImage(image)
	self.image = image
	return Metro.CacheEntry(image)
end

function Metro.ImageCache()
	return setmetatable({}, META)
end