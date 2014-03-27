include( "metro/ui/Frame.lua" )
include( "metro/ui/Label.lua" )
include( "metro/ui/Button.lua" )
include( "metro/ui/Resizegrip.lua" )
include( "metro/ui/Tooltip.lua" )
include( "metro/ui/TextEntry.lua" )
include( "metro/ui/ListView_Line.lua" )
include( "metro/ui/ListView.lua" )
include( "metro/ui/ListView_Column.lua" )
include( "metro/ui/VScrollBar.lua" )
include( "metro/ui/ScrollBarGrip.lua" )
include( "metro/ui/PropertySheet.lua" )
include( "metro/ui/MenuBar.lua" )
--
--[[
include( "metro/ui/DDragBase.lua" )
include( "metro/ui/DImage.lua" )
include( "metro/ui/DPanel.lua" )
include( "metro/ui/DHorizontalScroller.lua" )
include( "metro/ui/DPanelList.lua" )
include( "metro/ui/DListLayout.lua" )
include( "metro/ui/DCategoryCollapse.lua" )
include( "metro/ui/DForm.lua" )
include( "metro/ui/DComboBox.lua" )
include( "metro/ui/DCheckBox.lua" )
include( "metro/ui/DNumberWang.lua" )
include( "metro/ui/DMenu.lua" )
include( "metro/ui/DMenuOption.lua" )
include( "metro/ui/DColumnSheet.lua" )
include( "metro/ui/DScrollPanel.lua" )
include( "metro/ui/DGrid.lua" )
include( "metro/ui/DLabelURL.lua" )
include( "metro/ui/DHTMLControls.lua" )
include( "metro/ui/DImageButton.lua" )
include( "metro/ui/DHTML.lua" )
include( "metro/ui/DPanelOverlay.lua" )
include( "metro/ui/DDrawer.lua" )
include( "metro/ui/DTree.lua" )
include( "metro/ui/DTree_Node.lua" )
include( "metro/ui/DTree_Node_Button.lua" )
include( "metro/ui/DExpandButton.lua" )
include( "metro/ui/DNumSlider.lua" )
include( "metro/ui/DSlider.lua" )
include( "metro/ui/DProgress.lua" )
include( "metro/ui/DCategoryList.lua" )
include( "metro/ui/DSizeToContents.lua" )
include( "metro/ui/DIconBrowser.lua" )
include( "metro/ui/DIconLayout.lua" )
include( "metro/ui/DColorMixer.lua" )
include( "metro/ui/DColorCube.lua" )
include( "metro/ui/DAlphaBar.lua" )
include( "metro/ui/DRGBPicker.lua" )
]]
--[[
local frametest = Metro.CreateFrame()
frametest:SetSizable(true)
--local grip = Metro.Create("MetroResizeGrip", frametest)
local button = Metro.Create("MetroButton", frametest)
button:Dock(TOP)
button:SetTooltip("Testing tooltip stuff")
local text = Metro.Create("MetroTextEntry", frametest)
text:Dock(TOP)
--text:SetDisabled(true)

]]
if ValidPanel(frametest2) then
	frametest2:Remove()
end
frametest2 = Metro.CreateFrame(600,500)
frametest2:SetSizable(true)
local PropertySheet = Metro.Create( "MetroPropertySheet", frametest2 )
PropertySheet:Dock(FILL)

TheList = Metro.Create( "MetroListView" )
TheList:Dock(FILL)
local Col1 = TheList:AddColumn( "Address" )
local Col2 = TheList:AddColumn( "Port" )

Col2:SetMinWidth( 55 )
Col2:SetMaxWidth( 55 )
for i = 0,50 do
	TheList:AddLine( "192.168.0."..i, "80" ):SetIcon("icon16/user.png")
end

TheList2 = Metro.Create( "MetroListView" )
TheList2:Dock(FILL)
local Col1 = TheList2:AddColumn( "Address" )
local Col2 = TheList2:AddColumn( "Port" )

Col2:SetMinWidth( 70 )
Col2:SetMaxWidth( 70 )
for i = 0,50 do
	TheList2:AddLine( "192.168."..i..".1", "27015" )
end
PropertySheet:AddSheet( "Clients", TheList, "icon16/group.png", false, false )
PropertySheet:AddSheet( "Servers", TheList2, "icon16/server.png", false, false )
--[[
if ValidPanel(frametest3) then
	frametest3:Remove()
end
frametest3 = Metro.CreateFrame(600,500)
frametest3:SetSizable(true)

local UpMenu = Metro.Create( "MetroMenuBar", frametest3 )
UpMenu:Dock(TOP)

local fileMenu = UpMenu:AddMenu ("File")
fileMenu:AddOption ("New", function() end):SetIcon ("icon16/page_white_add.png")
fileMenu:AddOption ("Save", function() end):SetIcon ("icon16/disk.png")
local editMenu = UpMenu:AddMenu ("Edit")
editMenu:AddOption ("Undo", function()end):SetIcon ("icon16/arrow_undo.png")
local viewMenu = UpMenu:AddMenu ("View")
viewMenu:AddOption ("Mode", function() end):SetIcon ("icon16/application_view_list.png")

]]