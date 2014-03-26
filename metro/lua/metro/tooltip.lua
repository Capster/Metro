local Tooltip = nil
local TooltippedPanel = nil

function RemoveTooltip( PositionPanel )

	if not IsValid( Tooltip ) then return true end
		
	Tooltip:Close()
	Tooltip = nil
	return true

end

function FindTooltip( panel )

	while panel and panel:IsValid() do
	
		if  panel.strTooltipText or panel.pnlTooltipPanel  then
			return panel.strTooltipText, panel.pnlTooltipPanel, panel
		end
		
		panel = panel:GetParent()
	
	end
	
end

function ChangeTooltip( panel )

	RemoveTooltip()
	
	local Text, Panel, PositionPanel = FindTooltip( panel )
	
	if not Text and not Panel then return end

	Tooltip = vgui.Create( "MetroTooltip" )
	
	if Text then
	
		Tooltip:SetText( Text )
		
	else
	
		Tooltip:SetContents( Panel, false )
	
	end

	Tooltip:OpenForPanel( PositionPanel )
	TooltippedPanel = panel

end

function EndTooltip( panel )

	if not TooltippedPanel then return end
	if TooltippedPanel != panel then return end

	RemoveTooltip()

end