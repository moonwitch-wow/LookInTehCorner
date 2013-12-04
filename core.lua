----------------------------------------------------------------------------------------------------
--  Look In Teh Corner!  --
--  Big thanks to haste"s oMinimap on which this is based.
--  I mainly added coordinates, changed some positions,
--  but as per his copyright thingie, the addon has changed name.
--  I would like to thank Lyn for the awesome name.
----------------------------------------------------------------------------------------------------

-- Configuration and lessening the typing strains of the world.
--local color = RAID_CLASS_COLORS[select(2, UnitClass("Player"))] -- if you don"t want classcolored borders, then you can comment this out (add -- in front)
local color = {.6, .6, .6, 1} -- uncomment and alter values for a set color ( {r, g, b, a} )
local font = "Fonts\\ARIALN.ttf"
local scale = 1.1
local backdrop = {
    bgFile = "Interface\\Buttons\\WHITE8x8",
    edgeFile = "Interface\\Buttons\\WHITE8x8",
    tiled = true,
    edgeSize = 1,
    insets = { left = -1, right = -1, top = -1, bottom = -1}
  }
local backdropColor = { .1,.1,.1,1 }
local borderColor = { .6,.6,.6,1 }

-- Global fluff
function GetMinimapShape() return "SQUARE" end

-- Frame creation
local LookInTehCorner, events = CreateFrame("Frame", "LookInTehCorner", Minimap), {}

local frames = {
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

-- Frame fluff
function events:PLAYER_ENTERING_WORLD(...)
  Minimap:ClearAllPoints()
  Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -15, -15)
  Minimap:SetMovable(true)
  Minimap:SetUserPlaced(true)
  Minimap:EnableMouse(true)
  Minimap:RegisterForDrag("LeftButton")
  Minimap:SetScript("OnDragStart", function(self) self:StartMoving() end)
  Minimap:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  Minimap:SetFrameLevel(2)

  --self:SetParent(Minimap)
  self:SetAllPoints(Minimap)
  self:SetWidth(Minimap:GetWidth()*scale)
  self:SetHeight(Minimap:GetHeight()*scale)
  self:SetFrameLevel(1)
  self:SetFrameStrata("BACKGROUND")

  Minimap:SetScale(scale)
  Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground")
  Minimap:SetBackdrop(backdrop)
  Minimap:SetBackdropColor(r, g, b, a)
  Minimap:SetBackdropBorderColor(backdropColor.r, backdropColor.g, backdropColor.b)

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
  MiniMapTrackingIcon:SetTexCoord(0.065, 0.935, 0.065, 0.935)
  MiniMapTracking:SetParent(Minimap)
  MiniMapTracking:ClearAllPoints()
  MiniMapTracking:SetScale(.8)
  MiniMapTracking:SetPoint("TOPLEFT", -2, 2)

--[[ PvP Icon
  MiniMapBattlefieldFrame:SetParent(Minimap)
  MiniMapBattlefieldFrame:ClearAllPoints()
  MiniMapBattlefieldFrame:SetPoint("TOPRIGHT", -2, -2)]]

-- Mail icon changes
  MiniMapMailIcon:SetTexture("Interface\\AddOns\\LookInTehCorner\\media\\mail") -- remove this line if you want the default mail icon to show
  MiniMapMailFrame:ClearAllPoints()
  MiniMapMailFrame:SetPoint("BOTTOM", Minimap,"BOTTOM")

-- Minimap zone text stuff.
  --MinimapZoneText:Hide() -- remove -- if you want to hide the ZoneText and add -- in front of the following lines.
  MinimapZoneText:SetDrawLayer"OVERLAY"
  MinimapZoneText:ClearAllPoints()
  MinimapZoneText:SetPoint("LEFT", Minimap, 5, 0)
  MinimapZoneText:SetPoint("RIGHT", Minimap, -5, 0)
  MinimapZoneText:SetPoint("BOTTOM", Minimap, "TOP", 0, 5)
  MinimapZoneText:SetFont(font, 11)
  MinimapZoneText:SetJustifyH("CENTER")

-- World PvP Frame
  if (WorldStateCaptureBar) then
    WorldStateCaptureBar:ClearAllPoints()
    WorldStateCaptureBar:SetPoint("TOP", UIParent, "TOP", -75, -50)
    WorldStateCaptureBar.SetPoint = function() end
    WorldStateCaptureBar.ClearAllPoints = function() end
  end

  -- shitty 3.3 flag to move
  MiniMapInstanceDifficulty:ClearAllPoints()
  MiniMapInstanceDifficulty:SetParent(Minimap)
  MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)
  MiniMapInstanceDifficulty:SetScale(.7)

  -- 4.0.6 Guild instance difficulty
  GuildInstanceDifficulty:ClearAllPoints()
  GuildInstanceDifficulty:SetParent(Minimap)
  GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
  GuildInstanceDifficulty:SetScale(.7)

  -- LFG Eye
  MiniMapLFGFrame:SetParent(Minimap)
  MiniMapLFGFrame:SetHighlightTexture(nil)
  LFDSearchStatus:SetClampedToScreen(true)

  --[[ Quest Watcher Frame
  WatchFrame:ClearAllPoints()
  WatchFrame.ClearAllPoints = function() end
  WatchFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, -15)
  WatchFrame.SetPoint = function() end
  WatchFrame:SetClampedToScreen(true)
--]]
-- Frame hiding
  for _, frame in pairs(frames) do
    frame:Hide()
  end
  frames = nil

  self:UnregisterEvent"ADDON_LOADED"
end


-- Event handling
LookInTehCorner:SetScript("OnEvent", function(self, event, ...) self[event](self) end)
LookInTehCorner:RegisterEvent"PLAYER_LOGIN"
LookInTehCorner:RegisterEvent"CALENDAR_UPDATE_PENDING_INVITES"