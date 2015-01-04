------------------------------------------------------------------------
--  Look In Teh Corner!  --
--  Big thanks to haste's oMinimap on which this is based.
--  I mainly added coordinates, changed some positions,
--  but as per his copyright thingie, the addon has changed name.
--  I would like to thank Lyn for the awesome name.
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Configuration and lessening the typing strains of the world.
------------------------------------------------------------------------
local font = STANDARD_TEXT_FONT
local scale = 1.2
local backdrop = {
    bgFile = "Interface\\Buttons\\WHITE8x8",
    insets = { left = -2, right = -2, top = -2, bottom = -2}
  }
local backdropColor = { r = .1, g = .1, b = .1, a = .9 }
local showZoneText = true -- true shows zonetext

-- This is needed to properly ping the minimap
function GetMinimapShape() return "SQUARE" end

-- Frame creation and event handler
local LookInTehCorner = CreateFrame("Frame", "LookInTehCorner", Minimap)
LookInTehCorner:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)
LookInTehCorner:RegisterEvent"PLAYER_LOGIN"

local hiddenFrames = {
  MinimapBorder,
  MinimapBorderTop,
  MinimapToggleButton,
  MinimapZoomIn,
  MinimapZoomOut,
  MiniMapTrackingBackground,
  MiniMapBattlefieldBorder,
  MiniMapMeetingStoneFrame,
  MiniMapVoiceChatFrame,
  MiniMapWorldMapButton,
  MiniMapMailBorder,
  BattlegroundShine,
  MiniMapZoneTextButton,
  GameTimeFrame
}

------------------------------------------------------------------------
-- Util funcs
------------------------------------------------------------------------
function LookInTehCorner:GetLocTextColor()
  local pvpType = GetZonePVPInfo()
  if pvpType == "arena" then
    return 0.84, 0.03, 0.03
  elseif pvpType == "friendly" then
    return 0.05, 0.85, 0.03
  elseif pvpType == "contested" then
    return 0.9, 0.85, 0.05
  elseif pvpType == "hostile" then
    return 0.84, 0.03, 0.03
  elseif pvpType == "sanctuary" then
    return 0.035, 0.58, 0.84
  elseif pvpType == "combat" then
    return 0.84, 0.03, 0.03
  else
    return 0.84, 0.03, 0.03
  end
end

------------------------------------------------------------------------
-- PLAYER LOGIN func - the main shebang
------------------------------------------------------------------------
function LookInTehCorner:PLAYER_LOGIN(...)
  Minimap:ClearAllPoints()
  Minimap:SetParent(UIParent)
  Minimap:SetPoint("TOPRIGHT", -10, -10)
  Minimap:SetBackdrop(backdrop)
  Minimap:SetBackdropColor(0, 0, 0)
  Minimap:SetScale(scale)
  Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground")
  Minimap:SetArchBlobRingScalar(0)
  Minimap:SetQuestBlobRingScalar(0)

  -- Scrolling with mousewheel
  Minimap:EnableMouseWheel()
  Minimap:SetScript("OnMouseWheel", function(self, dir)
    if(dir > 0) then
      Minimap_ZoomIn()
    else
      Minimap_ZoomOut()
    end
  end)

  MiniMapTrackingIconOverlay:SetAlpha(0)
  MiniMapTrackingButtonBorder:Hide()
  MiniMapTracking:Hide()

-- Mail icon changes
  -- MiniMapMailIcon:SetTexture("Interface\\AddOns\\LookInTehCorner\\media\\mail") -- remove this line if you want the default mail icon to show
  MiniMapMailFrame:ClearAllPoints()
  MiniMapMailFrame:SetPoint("BOTTOM", Minimap,"BOTTOM", 0, -10)
  MiniMapMailFrame:SetSize(50, 20)
  MiniMapMailFrame:SetScale(1 / scale)
  MiniMapMailIcon:SetTexture("")
  MiniMapMailBorder:SetTexture("")
  Minimap.mailText = MiniMapMailFrame:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
  Minimap.mailText:SetPoint("BOTTOM")
  Minimap.mailText:SetTextColor(1, 0.9, 0.8)
  Minimap.mailText:SetText("Mail!")

-- Garrison icon
  GarrisonLandingPageMinimapButton:ClearAllPoints()
  GarrisonLandingPageMinimapButton:SetPoint("TOPRIGHT", Minimap, 3, 2)
  GarrisonLandingPageMinimapButton:SetSize(32, 32)

-- Minimap zone text stuff.
  if (showZoneText) then
    MinimapZoneText:SetParent(Minimap)
    MinimapZoneText:SetDrawLayer"OVERLAY"
    MinimapZoneText:ClearAllPoints()
    MinimapZoneText:SetPoint("TOPLEFT", Minimap, 5, 0)
    MinimapZoneText:SetPoint("TOPRIGHT", Minimap, -5, 0)
    MinimapZoneText:SetFont(font, 10)
    MinimapZoneText:SetJustifyH("CENTER")
  else
    MinimapZoneText:Hide()
  end

-- World PvP Frame
  if (WorldStateCaptureBar) then
    WorldStateCaptureBar:ClearAllPoints()
    WorldStateCaptureBar:SetPoint("TOP", UIParent, "TOP", -75, -50)
    WorldStateCaptureBar.SetPoint = function() end
    WorldStateCaptureBar.ClearAllPoints = function() end
  end

  MiniMapInstanceDifficulty:ClearAllPoints()
  MiniMapInstanceDifficulty:Hide()

  GuildInstanceDifficulty:ClearAllPoints()
  GuildInstanceDifficulty:Hide()

  QueueStatusMinimapButton:ClearAllPoints()
  QueueStatusMinimapButton:SetParent(Minimap)
  QueueStatusMinimapButton:SetPoint("TOPLEFT", Minimap, 1, -1)

-- Frame hiding
  for _, frame in pairs(hiddenFrames) do
    frame:Hide()
  end
  hiddenFrames = nil

  self:UnregisterEvent"ADDON_LOADED"
end

function LookInTehCorner:ZONE_CHANGED(...)

  MinimapZoneText:SetTextColor(LookInTehCorner:GetLocTextColor())

  self:RegisterEvent"ZONE_CHANGED_INDOORS"
  self:RegisterEvent"ZONE_CHANGED_NEW_AREA"
end

