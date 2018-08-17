------------------------------------------------------------------------
-- Simple DataBroker frame at the bottom of the minimap
------------------------------------------------------------------------
local brokerwidth = Minimap:GetWidth()

local LCS = LibStub("LibCargoShip-2.1")
local block = LCS:CreateBlock{
    width = brokerwidth,
    parent = Minimap,
    noIcon = false,
    scale = 1,
    fontSize = 11
}
block:SetDataObject("DPS")
block:SetPoint("TOP", Minimap, "BOTTOM", 0, -15)