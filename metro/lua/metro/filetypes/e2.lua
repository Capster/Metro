local type = {}

type.Name = "Expression2"
type.Icon = "icon16/page_red.png"

function type:Callback(strContent)
	
end

Metro.FileTypes:Register(type.Name, nil, type.Callback, type.Icon)