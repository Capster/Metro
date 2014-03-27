local type = {}

type.Name = "Config"
type.Icon = "icon16/page_white_gear.png"
type.Extension = ".cfg"

function type:Callback(strContent)
	
end

Metro.FileTypes:Register(type.Name, type.Extension, type.Callback, type.Icon)