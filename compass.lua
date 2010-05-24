MinimapNorthTag:SetAlpha(0)

local Compass = CreateFrame("Frame", "Compass", Minimap)
Compass:SetAllPoints()
for dir,anchor in pairs{W = "LEFT", S = "BOTTOM", E = "RIGHT", N = "TOP"} do
	local key = Compass:CreateFontString()
	key:SetFontObject(GameFontWhite)
	key:SetPoint("CENTER", Compass, anchor)
	key:SetText(dir)
end

--Compass:Show()
Compass:Hide()