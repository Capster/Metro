local type = {}

type.Name = "Database"
type.Icon = "icon16/database.png"
type.Extension = ".db"

function type:Callback(strContent)
	
end

Metro.FileTypes:Register(type.Name, type.Extension, type.Callback, type.Icon)