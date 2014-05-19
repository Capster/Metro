Metro.PostRenderHooks = {}

Metro.PostRenderType = {
	DragDropPreview	= 1,
	ToolTip			= 2,
	ToolTipFix		= 3
}

hook.Add ("PostRenderVGUI", "Metro.PostRenderHook", function ()
	if Metro.PostRenderHooks [Metro.PostRenderType.DragDropPreview] then
		for k, v in pairs (Metro.PostRenderHooks [Metro.PostRenderType.DragDropPreview]) do
			xpcall (v, Error)
		end
	end
	if Metro.PostRenderHooks [Metro.PostRenderType.ToolTip] then
		for k, v in pairs (Metro.PostRenderHooks [Metro.PostRenderType.ToolTip]) do
			xpcall (v, Error)
		end
	end
end)

function Metro.AddPostRenderHook (renderType, name, renderFunction)
	Metro.PostRenderHooks [renderType] = Metro.PostRenderHooks [renderType] or {}
	Metro.PostRenderHooks [renderType] [name] = renderFunction or function() end
end

function Metro.RemovePostRenderHook (renderType, name)	
	if not Metro.PostRenderHooks [renderType] then return end
	Metro.PostRenderHooks [renderType] [name] = nil
	if not next (Metro.PostRenderHooks [renderType]) then
		Metro.PostRenderHooks [renderType] = nil
	end
end