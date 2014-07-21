Metro.PostRender = {}

Metro.RenderType = {
	DragDrop		= 1,
	ToolTip			= 2,
	ToolTipFix		= 3
}

local hooks = {}

function Metro.PostRender.Add(numEnum, strName, funcCallback)
	hooks[numEnum] = hooks[numEnum] or {}
	hooks[numEnum][strName] = funcCallback
end

function Metro.PostRender.Get()
	return hooks
end

function Metro.PostRender.Remove(numEnum, strName)	
	hooks[numEnum][strName] = hooks[numEnum] and nil
end

hook.Add("PostRenderVGUI", "Metro.PostRenderHook", function()
	for k,v in pairs(Metro.RenderType) do
		if not hooks[v] then continue end
		for numKey, funcCallback in pairs(v) do
			funcCallback()
		end
	end
end)