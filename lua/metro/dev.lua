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
--[[
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
]]
--[[
if ValidPanel(frametest3) then
	frametest3:Remove()
end
frametest3 = Metro.CreateFrame(1200,800)
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

local html = Metro.Create( "MetroHTML", frametest3 )
html:Dock(FILL)
html:OpenURL("http://www.intel.ru/content/www/ru/ru/homepage.html")
html:CreateAlert( "Awesomium Запрашивает доступ к ClientSide Lua", callback )
]]