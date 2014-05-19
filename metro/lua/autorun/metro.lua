include("fastlua.lua")
if CLIENT then
	include("metro/metro.lua")
	include("metro/loader.lua")
else
	AddCSLuaFile("metro/metro.lua")
	AddCSLuaFile("metro/loader.lua")
end