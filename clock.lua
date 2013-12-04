if(not IsAddOnLoaded("Blizzard_TimeManager")) then
	LoadAddOn("Blizzard_TimeManager")
end

local function OnClick(self, button)
	if(self.alarmFiring) then
		PlaySound("igMainMenuQuit")
		TimeManager_TurnOffAlarm()
	else
		if(button == "RightButton") then
			ToggleCalendar()
		else
			if(not IsAddOnLoaded("Blizzard_Calendar")) then
				LoadAddOn("Blizzard_Calendar")
			end
			ToggleTimeManager()
		end
	end
end

LookInTehCorner.CALENDAR_UPDATE_PENDING_INVITES = function()
	if(CalendarGetNumPendingInvites() ~= 0) then
		TimeManagerClockTicker:SetTextColor(0, 1, 0)
	else
		TimeManagerClockTicker:SetTextColor(1, .8, 0)
	end
end

TimeManagerClockButton:ClearAllPoints()
TimeManagerClockButton:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT")
TimeManagerClockButton:SetWidth(40)
TimeManagerClockButton:SetHeight(14)
TimeManagerClockButton:GetRegions():Hide()
TimeManagerClockButton:Show()

select(1, TimeManagerClockButton:GetRegions()):Hide()

TimeManagerClockTicker:SetPoint("CENTER", TimeManagerClockButton)
TimeManagerClockTicker:SetFont(STANDARD_TEXT_FONT, 12, "THINOUTLINE")
TimeManagerClockTicker:SetTextColor(1, .8, 0)

TimeManagerAlarmFiredTexture.Show = function() TimeManagerClockTicker:SetTextColor(1, 0, 0) end
TimeManagerAlarmFiredTexture.Hide = function() TimeManagerClockTicker:SetTextColor(1, 1, 1) end

local clockFlash = select(3, TimeManagerClockButton:GetRegions())
clockFlash.Show = function() TimeManagerClockTicker:SetTextColor(1, 0, 0) end
clockFlash.Hide = function() TimeManagerClockTicker:SetTextColor(1, .8, 0) end

-- Event Handlers
TimeManagerClockButton:SetScript("OnClick", OnClick)