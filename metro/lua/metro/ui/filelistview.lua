
	
local PANEL = {}

fastlua.Bind(PANEL, "Folder", "")
fastlua.Bind(PANEL, "FileSystem", "GAME")

function PANEL:Init()

	self:SetMultiSelect(false)
	local name = self:AddColumn("Name") 
	local size = self:AddColumn("Size")
	size:SetMinWidth( 50 )
	size:SetMaxWidth( 100 )
	
	self:LoadFolder(self:GetFolder())
end

function PANEL:LoadFolder(path)
	local f, p = file.Find(path.."*", self:GetFileSystem())
	for k,v in pairs(p) do
		local line = self:AddLine(v,"0")
		line:SetIcon("icon16/folder.png")
		line.IsFolder = true
	end
	for key, fileName in pairs(f) do
		local str = self:AddLine(fileName, "0")
		local strExtension = Metro.FileTypes:GetExtensionFromName(fileName)
		local type = Metro.FileTypes:GetTypeFromExtension(strExtension)
		str:SetIcon(type.Icon)
	end
end

function PANEL:DoDoubleClick( LineID, Line )
	if Line.IsFolder then
		local nextfolder = Line.Icon and string.Replace( nextfolder, "      ", "" ) or Line:GetColumnText( 1 )
		local curfolder = self:GetFolder()
		nextfolder = curfolder..nextfolder.."/"
		print(nextfolder)
		self:OpenFolder(nextfolder)
		PrintTable(file.Find(nextfolder, self:GetFileSystem()))
	end
end

function PANEL:OpenFolder(path)
	self:SetFolder(path)
	self:Clear()
	self:LoadFolder(self:GetFolder())
end

Metro.Register( "MetroFileListView", PANEL, "MetroListView" )