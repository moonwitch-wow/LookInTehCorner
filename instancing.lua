--[[ Instance Difficulty - should work now finally taken from Wanderlust by Ichik]]

local _, class = UnitClass("player")
local color = RAID_CLASS_COLORS[class]
local id = CreateFrame("Frame", nil, UIParent)
LookInTehCorner:RegisterEvent("PLAYER_ENTERING_WORLD")
LookInTehCorner:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")

local idtext = id:CreateFontString(nil, "OVERLAY")
idtext:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, -4)
idtext:SetFont("Fonts\\FRIZQT__.ttf", 14, "THINOUTLINE")
idtext:SetTextColor(color.r, color.g, color.b)

function indiff()
	local instance, instancetype = IsInInstance()
	local _, _, difficultyIndex, _, _, playerDifficulty, isDynamic = GetInstanceInfo()
	if instance and instancetype == "raid" then
		if isDynamic and difficultyIndex == 1 then
			if playerDifficulty == 0 then
				idtext:SetText("10") end
			if playerDifficulty == 1 then
				idtext:SetText("10H") end
			end
		if isDynamic and difficultyIndex == 2 then
			if playerDifficulty == 0 then
				idtext:SetText("25") end
			if playerDifficulty == 1 then
				idtext:SetText("25H") end
			end
		if not isDynamic then
			if difficultyIndex == 1 then
				idtext:SetText("10") end
			if difficultyIndex == 2 then
				idtext:SetText("25") end
			if difficultyIndex == 3 then
				idtext:SetText("10H") end
			if difficultyIndex == 4 then
				idtext:SetText("25H") end
			end
		end
	if not instance then
		idtext:SetText("") end
end
id:SetScript("OnEvent", function() indiff() end)