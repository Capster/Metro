local type = {}

type.Name = "Text"
type.Icon = "icon16/page_white_text.png"
type.Extension = ".txt"

function type:Callback(strContent)
	
end

Metro.FileTypes:Register(type.Name, type.Extension, type.Callback, type.Icon)