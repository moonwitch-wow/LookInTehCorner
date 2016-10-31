--[[ Instance Difficulty - should work now finally taken from Wanderlust by Ichik]]

local _, class = UnitClass("player")
local color = RAID_CLASS_COLORS[class]
local id = CreateFrame("Frame", nil, UIParent)

local idtext = id:CreateFontString(nil, "OVERLAY")
idtext:SetPoint("RIGHT", Minimap, "RIGHT", 0, -4)
idtext:SetFont(STANDARD_TEXT_FONT, 11)
idtext:SetTextColor(color.r, color.g, color.b)

local _, class = UnitClass("player")
local color = RAID_CLASS_COLORS[class]

local id = CreateFrame("Frame", nil, Minimap)
id:SetFrameLevel(4)
id:SetPoint("RIGHT", Minimap, "RIGHT")

local idtext = id:CreateFontString(nil, "OVERLAY")
idtext:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)
idtext:SetFont("Fonts\\FRIZQT__.ttf", 10, "THINOUTLINE")
idtext:SetTextColor(color.r, color.g, color.b)

function indiff()
	local inInstance, instancetype = IsInInstance()
	local _, _, difficultyIndex, _, maxPlayers, playerDifficulty, isDynamic = GetInstanceInfo()
	if inInstance then
		if difficultyIndex == 0 then idtext:SetText("")
			elseif difficultyIndex == 1 then idtext:SetText("[5]")
			elseif difficultyIndex == 2 then idtext:SetText("[5HC]")
			elseif difficultyIndex == 3 then idtext:SetText("[10]")
			elseif difficultyIndex == 4 then idtext:SetText("[25]")
			elseif difficultyIndex == 5 then idtext:SetText("[10HC]")
			elseif difficultyIndex == 6 then idtext:SetText("[25HC]")
			elseif difficultyIndex == 7 then idtext:SetText("[RF]")
			elseif difficultyIndex == 8 then idtext:SetText("[CM]")
			elseif difficultyIndex == 9 then idtext:SetText("[40]")
			elseif difficultyIndex == 11 then idtext:SetText("[HScen]")
			elseif difficultyIndex == 12 then idtext:SetText("[Scen]")
			elseif difficultyIndex == 13 then idtext:SetText("[Flex]")
			elseif difficultyIndex == 14 then idtext:SetText(maxPlayers.."N")
			elseif difficultyIndex == 15 then idtext:SetText(maxPlayers.."H")
			elseif difficultyIndex == 16 then idtext:SetText("[M]")
			elseif difficultyIndex == 17 then idtext:SetText("[LFR]")
			else idtext:SetText("")
		end
	end
	if GuildInstanceDifficulty:IsShown() then
		idtext:SetTextColor(0, .9, 0)
	end
end

id:SetScript("OnEvent", function() indiff() end)
id:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
id:RegisterEvent("UPDATE_INSTANCE_INFO")
id:RegisterEvent("GROUP_ROSTER_UPDATE")
id:RegisterEvent("PLAYER_GUILD_UPDATE")
id:RegisterEvent("PARTY_MEMBER_ENABLE")
id:RegisterEvent("PARTY_MEMBER_DISABLE")
id:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
id:RegisterEvent("PLAYER_ENTERING_WORLD")
id:RegisterEvent("ZONE_CHANGED_NEW_AREA")
