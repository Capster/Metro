local type = {}

type.Name = "C++"
type.Icon = "icon16/page_white_cpp.png"
type.Extension = ".cpp"

function type:Callback(strContent)
	
end

Metro.FileTypes:Register(type.Name, type.Extension, type.Callback, type.Icon)