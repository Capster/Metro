Metro.FileTypes = {}
Metro.FileTypes.Types = {}

function Metro.FileTypes:Register(strName, strExtension, funcOnRead, strIcon)
	Metro.FileTypes.Types[strName] = {Extension = strExtension, Callback = funcOnRead, Icon = strIcon}
end

function Metro.FileTypes:UnRegister(strName)
	Metro.FileTypes.Types[strName] = nil
end

function Metro.FileTypes:GetTypeFromExtension(strExtension)
	for key, type in pairs(Metro.FileTypes.Types) do
		if type.Extension == strExtension then
				return type
		end
	end
	return Metro.FileTypes.Types["Base"]
end

function Metro.FileTypes:GetType(strName)
	return Metro.FileTypes.Types[strName]
end

function Metro.FileTypes:GetExtensionFromName(strName)
	tblParts = string.Explode( ".", strName )
	return "."..tblParts[#tblParts]
end