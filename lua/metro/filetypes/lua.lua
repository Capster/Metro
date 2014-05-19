local type = {}

type.Name = "GLua" -- Or Lua?
type.Icon = "icon16/page_code.png"
type.Extension = ".lua"

function type:Callback(strContent)
	
end

Metro.FileTypes:Register(type.Name, type.Extension, type.Callback, type.Icon)