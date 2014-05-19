local type = {}

type.Name = "Base"
type.Icon = "icon16/page_delete.png"

function type:Callback(strContent)
	
end

Metro.FileTypes:Register(type.Name, nil, type.Callback, type.Icon)