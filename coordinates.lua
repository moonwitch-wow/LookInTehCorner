-- Coordinates for LookInTehCorner
local GetPlayerMapPosition = C_Map.GetPlayerMapPosition
local GetBestMapForUnit = C_Map.GetBestMapForUnit

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
local updateCoords = function(self, elapsed)
	local uiMapID = GetBestMapForUnit("player")
	if uiMapID then
		local tbl = GetPlayerMapPosition(uiMapID, "player")
		if tbl then
			coordsf:SetFormattedText("%.1f, %.1f", tbl.x*100, tbl.y*100)
		else
			coordsf:SetText("00.0, 00.0")
		end
	end
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

Coords:SetScript('OnUpdate', updateCoords)
Coords:SetScript('OnClick', onClickCoord)
Coords:RegisterEvent'ZONE_CHANGED_NEW_AREA'