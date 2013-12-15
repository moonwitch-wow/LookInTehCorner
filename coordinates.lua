-- Coordinates for LookInTehCorner

local Coords = CreateFrame('Button', nil, Minimap)
local coordsf = Coords:CreateFontString(nil, 'OVERLAY')
coordsf:SetPoint('BOTTOMLEFT', Minimap, 'BOTTOMLEFT', 1, 1)
coordsf:SetJustifyH('LEFT')
coordsf:SetWidth(75)
coordsf:SetHeight(12)
coordsf:SetTextColor(1, .8, 0)
coordsf:SetShadowColor(0, 0, 0, .7)
coordsf:SetShadowOffset(1, -1)
coordsf:SetFont(STANDARD_TEXT_FONT, 11)

-- Coordinate functions DO NOT TOUCH
local coords = function(self, elapsed)
	local x, y = GetPlayerMapPosition('player')
	coordsf:SetFormattedText('%.0f,%.0f', x * 100, y * 100)
end

-- doesn't work
function onClickCoord(self, button)
	if(button == 'RightButton') then
		ToggleBattlefieldMinimap()
	else
		ToggleFrame(WorldMapFrame)
	end
end

if (event == 'ZONE_CHANGED_NEW_AREA') then
   SetMapToCurrentZone()
end

Coords:SetScript('OnUpdate', coords)
Coords:SetScript('OnClick', onClickCoord)
Coords:RegisterEvent'ZONE_CHANGED_NEW_AREA'