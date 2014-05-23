local PANEL = {}

AccessorFunc( PANEL, "m_strName", 			"Name" )
AccessorFunc( PANEL, "m_strPath", 			"Path" )
AccessorFunc( PANEL, "m_strFilter", 		"Files" )
AccessorFunc( PANEL, "m_strCurrentFolder", 	"CurrentFolder" )
AccessorFunc( PANEL, "m_bModels", 			"Models" )

function PANEL:Init()
	self.Tree = self:Add("DTree")
	self.Tree:Dock(LEFT)
	self.Tree:SetWidth(200)

	self.Tree.DoClick = function(_, node)
		if not node.FileName then return end
		self:ShowFolder(node.FileName)
	end
	self.Icons = self:Add("DIconBrowser")
	self.Icons:SetManual(true)
	self.Icons:Dock(FILL)
end

function PANEL:Paint(w, h)
	DPanel.Paint(self, w, h)
	if not self.bSetup then
		self:Setup()
		self.bSetup = true
	end
end

function PANEL:Setup()
	local root = self.Tree.RootNode:AddFolder("MetroFileBrowser", "lua", false)
	root:SetExpanded(true)
end

function PANEL:ShowFolder(path)
	self.Icons:Clear()
	local files = file.Find(path.."/*", "GAME")
	
	for k, v in pairs(files) do
		if self.m_bModels then		
			local button = self.Icons:Add("SpawnIcon")
			button:SetModel(path.."/"..v)
			button.DoClick = function()
				self:OnSelect(path.."/"..v, button)
			end			
		else
			local button = self.Icons:Add("MetroButton")
			button:SetText(v)
			button:SetSize(150, 20)
			button.DoClick = function()
				self:OnSelect(path.."/"..v, button)
			end
		end		
	end
end

function PANEL:OnSelect(path, button)
end

Metro.Register("MetroFileBrowser", PANEL, "DPanel") -- For debug