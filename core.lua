------------------------------------------------------------------------
--  Look In Teh Corner!  --
--  Big thanks to haste"s oMinimap on which this is based.
--  I mainly added coordinates, changed some positions,
--  but as per his copyright thingie, the addon has changed name.
--  I would like to thank Lyn for the awesome name.
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Configuration and lessening the typing strains of the world.
------------------------------------------------------------------------
local font = STANDARD_TEXT_FONT
local scale = 1
local backdrop = {
    bgFile = "Interface\\Buttons\\WHITE8x8",
    edgeFile = "Interface\\Buttons\\WHITE8x8",
    tiled = true,
    edgeSize = 1,
    insets = { left = -1, right = -1, top = -1, bottom = -1}
  }
local backdropColor = { r = .1, g = .1, b = .1, a = .8 }
local borderColor = { r = .3, g = .3, b = .3, a = .8 }
local showZoneText = true -- true shows zonetext

------------------------------------------------------------------------
-- Square maps ftw
------------------------------------------------------------------------
function GetMinimapShape() return "SQUARE" end

-- Frame creation
local LookInTehCorner, events = CreateFrame("Frame", "LookInTehCorner", Minimap), {}

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
function events:PLAYER_LOGIN(...)
  -- Relocating minimap and allowing it to be moved
  Minimap:ClearAllPoints()
  Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -10, -10)
  Minimap:SetMovable(true)
  Minimap:SetUserPlaced(true)
  Minimap:EnableMouse(true)
  Minimap:RegisterForDrag("LeftButton")
  Minimap:SetScript("OnDragStart", function(self) self:StartMoving() end)
  Minimap:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  Minimap:SetFrameLevel(2)
  Minimap:SetScale(scale)
  Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground")

  -- Why not use the Event Handler as border too?
  self:SetParent(Minimap)
  self:SetPoint('CENTER')
  self:SetWidth(Minimap:GetWidth()*scale+6)
  self:SetHeight(Minimap:GetHeight()*scale+6)
  self:SetFrameLevel(1)

  -- Giving it a border
  self:SetBackdrop(backdrop)
  self:SetBackdropColor(backdropColor.r, backdropColor.g, backdropColor.b, backdropColor.a)
  self:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)

-- mousewheel scrolling
  Minimap:EnableMouseWheel()
  Minimap:SetScript("OnMouseWheel", function(self, dir)
    if(dir > 0) then
      Minimap_ZoomIn()
    else
      Minimap_ZoomOut()
    end
  end)

-- Tracking menu changes
  MiniMapTrackingIconOverlay:SetAlpha(0)
  MiniMapTrackingButtonBorder:Hide()
  MiniMapTracking:Hide()
  -- MiniMapTrackingIcon:SetTexCoord(0.065, 0.935, 0.065, 0.935)
  -- MiniMapTracking:SetParent(Minimap)
  -- MiniMapTracking:ClearAllPoints()
  -- MiniMapTracking:SetScale(.8)
  -- MiniMapTracking:SetPoint("TOPLEFT", -2, 2)

--[[ PvP Icon
  MiniMapBattlefieldFrame:SetParent(Minimap)
  MiniMapBattlefieldFrame:ClearAllPoints()
  MiniMapBattlefieldFrame:SetPoint("TOPRIGHT", -2, -2)]]

-- Mail icon changes
  MiniMapMailIcon:SetTexture("Interface\\AddOns\\LookInTehCorner\\media\\mail") -- remove this line if you want the default mail icon to show
  MiniMapMailFrame:ClearAllPoints()
  MiniMapMailFrame:SetPoint("BOTTOM", Minimap,"BOTTOM", 0, -10)

-- Minimap zone text stuff.
  if (showZoneText == true) then
    MinimapZoneText:SetDrawLayer"OVERLAY"
    MinimapZoneText:ClearAllPoints()
    MinimapZoneText:SetPoint("LEFT", Minimap, 5, 0)
    MinimapZoneText:SetPoint("RIGHT", Minimap, -5, 0)
    MinimapZoneText:SetPoint("TOP", Minimap, "TOP", 0, -1)
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

  -- shitty 3.3 flag to move
  MiniMapInstanceDifficulty:ClearAllPoints()
  MiniMapInstanceDifficulty:Hide()
  -- MiniMapInstanceDifficulty:SetParent(Minimap)
  -- MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)
  -- MiniMapInstanceDifficulty:SetScale(.7)

  -- 4.0.6 Guild instance difficulty
  GuildInstanceDifficulty:ClearAllPoints()
  GuildInstanceDifficulty:Hide()
  -- GuildInstanceDifficulty:SetParent(Minimap)
  -- GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
  -- GuildInstanceDifficulty:SetScale(.7)

  -- LFG Eye
  local function UpdateLFG()
    MiniMapLFGFrame:ClearAllPoints()
    MiniMapLFGFrame:Point("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 2, 1)
    MiniMapLFGFrameBorder:Hide()
    MiniMapLFGFrame:SetParent(Minimap)
    MiniMapLFGFrame:SetHighlightTexture(nil)
    LFDSearchStatus:SetClampedToScreen(true)
  end
  hooksecurefunc("EyeTemplate_OnUpdate", UpdateLFG)

-- Frame hiding
  for _, frame in pairs(hiddenFrames) do
    frame:Hide()
  end
  hiddenFrames = nil

  self:UnregisterEvent"ADDON_LOADED"
end

function events:ZONE_CHANGED(...)

  MinimapZoneText:SetTextColor(LookInTehCorner:GetLocTextColor())

  self:RegisterEvent"ZONE_CHANGED_INDOORS"
  self:RegisterEvent"ZONE_CHANGED_NEW_AREA"
end

-- Event handling
LookInTehCorner:SetScript("OnEvent", function(self, event, ...)
 events[event](self, event, ...) -- call one of the functions above
end)
LookInTehCorner:RegisterEvent"PLAYER_LOGIN"