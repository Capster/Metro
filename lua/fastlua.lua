fastlua = {}

function fastlua.error(str, errorcode)
	MsgC(Color(225,100,100),"[FastLua] Error: "..str..(errorcode and "(ErrorCode: "..errorcode or ""))
end

--[[
Custom Bind
	usage:
		test = {}
		fastlua.Bind(test, "Lol", true)

		print(test:GetLol())
		test:SetLol(false)
		print(test:GetLol())
]]


function fastlua.Bind(destinationObject, variable, defaultValue)

	destinationObject[variable] = defaultValue
	
	destinationObject["Set"..variable] = function(self, object)
		self[variable] = object
	end
	
	destinationObject["Get"..variable] = function(self)
		return self[variable]
	end
	
	return event and event.Call(variable.."Changed") or hook.Run(variable.."Changed")
	
end

function fastlua:GetHashCode(destinationObject)

	if not destinationObject.__hash then
		destinationObject.__hash = string.sub (string.format ("%p", destinationObject), 3)
	end

	return destinationObject.__hash

end

function fastlua:GetSource()
    return debug.getinfo(1).short_src:gsub("\\", "/")
end

function fastlua:Folder()
    return fastlua.GetSource():GetPathFromFilename()
end

function fastlua:FileName()
    return fastlua.GetSource():GetFileFromFilename():Left(-1)
end

function fastlua:FullSource()
    return util.RelativePathToFull(fastlua.GetSource())
end

function fastlua:IncludeShared(path)
	return SERVER and include(path) or include(path)
end

function fastlua:IncludeClient(path)
	return CLIENT and include(path)
end

function fastlua:IncludeServer(path)
	return SERVER and include(path)
end

--[[
function fastlua.SetupTable(strObject)
	
end
]]