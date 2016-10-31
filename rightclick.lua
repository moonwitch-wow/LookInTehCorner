----------------------------------------------------------------------------------------
-- Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {text = "Character",
    func = function() ToggleCharacter("PaperDollFrame") end},
    {text = "Spellbook",
    func = function() ToggleSpellBook("spell") end},
    {text = "Talents",
    func = function() ToggleTalentFrame() end},
    {text = "Achievement",
    func = function() ToggleAchievementFrame() end},
    {text = "Social",
    func = function() ToggleFriendsFrame(1) end},
    {text = "PvP",
    func = function() ToggleFrame(PVPParentFrame) end},
    {text = "LFG",
    func = function() ToggleFrame(LFDParentFrame) end},
    {text = "LFRaid",
    func = function() ToggleFrame(LFRParentFrame) end},
    {text = "Garrison",
    func = function() GarrisonLandingPage_Toggle() end},
    {text = "Calendar",
    func = function()
    if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
        Calendar_Toggle()
    end},
    {text = "Customer Support",
    func = function() ToggleHelpFrame() end},
}

Minimap:SetScript("OnMouseDown", function(self, btn)
	if btn == "RightButton" then
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self)
	elseif btn == "LeftButton" and IsShiftKeyDown() then
		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	else
		Minimap_OnClick(self)
	end
end)