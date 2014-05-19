local type = {}

type.Name = "Header"
type.Icon = "icon16/page_white_h.png"
type.Extension = ".h"

function type:Callback(strContent)
	
end

Metro.FileTypes:Register(type.Name, type.Extension, type.Callback, type.Icon)