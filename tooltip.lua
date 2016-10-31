-- ------------------------------
-- -- Localizing some crap --
-- ------------------------------

-- local MEMTHRESH = 32
-- local string_format, math_modf, GetNetStats, GetFramerate, gcinfo = string.format, math.modf, GetNetStats, GetFramerate, gcinfo

-- local function ColorGradient(perc, r1, g1, b1, r2, g2, b2, r3, g3, b3)
-- 	if perc >= 1 then return r3, g3, b3 elseif perc <= 0 then return r1, g1, b1 end

-- 	local segment, relperc = math_modf(perc*2)
-- 	if segment == 1 then r1, g1, b1, r2, g2, b2 = r2, g2, b2, r3, g3, b3 end
-- 	return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
-- end

-- local function formats(value)
-- 	if(value > 999) then
-- 		return format('%.1f MiB', value / 1024)
-- 	else
-- 		return format('%.1f KiB', value)
-- 	end
-- end

-- ------------------------
-- --	  Tooltip!	  --
-- ------------------------

-- local onEnter = function(self)
-- 	GameTooltip:SetOwner(TimeManagerClockButton, "ANCHOR_BOTTOMRIGHT")

-- 	local fps = GetFramerate()
-- 	local r, g, b = ColorGradient(fps/75, 1,0,0, 1,1,0, 0,1,0)
-- 	GameTooltip:AddDoubleLine("FPS:", string_format("%.1f", fps), nil,nil,nil, r,g,b)

-- 	local _, _, lag = GetNetStats()
-- 	local r, g, b = ColorGradient(lag/1000, 0,1,0, 1,1,0, 1,0,0)
-- 	GameTooltip:AddDoubleLine("Lag:", lag.. " ms", nil,nil,nil, r,g,b)

-- 	GameTooltip:AddLine(" ")

-- 	local addons, addon, total = {}, {}, 0

-- 	for i=1, GetNumAddOns() do
-- 		addon = {GetAddOnInfo(i), GetAddOnMemoryUsage(i)}
-- 		table.insert(addons, addon)
-- 		total = total + GetAddOnMemoryUsage(i)
-- 	end

-- 	table.sort(addons, (function(a, b) return a[2] > b[2] end))

-- 	UpdateAddOnMemoryUsage()

-- 	for i,addons in pairs(addons) do
-- 		if addons[2] > MEMTHRESH then
-- 			local r, g, b = ColorGradient((addons[2] - MEMTHRESH)/768, 0,1,0, 1,1,0, 1,0,0)
-- 			local memstr = addons[2] > 1024 and string_format("%.1f MiB", addons[2]/1024) or string_format("%.1f KiB", addons[2])
-- 			GameTooltip:AddDoubleLine(addons[1], memstr, 1,1,1, r,g,b)
-- 		end
-- 	end

-- 	GameTooltip:AddLine(" ")

-- 	local r, g, b = ColorGradient(total/(40*1024), 0,1,0, 1,1,0, 1,0,0)
-- 	GameTooltip:AddDoubleLine("Addon memory:", string_format("%.2f MiB", total/1024), nil,nil,nil, r,g,b)

-- 	local mem = collectgarbage("count")
-- 	local r, g, b = ColorGradient(mem/(20*1024), 0,1,0, 1,1,0, 1,0,0)
-- 	GameTooltip:AddDoubleLine("Default UI memory:", string_format("%.2f MiB", (gcinfo()-total)/1024), nil,nil,nil, r,g,b)

-- 	GameTooltip:AddLine(" ")

-- 	GameTooltip:Show()
-- end

-- TimeManagerClockButton:SetScript("OnEnter", onEnter)
-- TimeManagerClockButton:SetScript("OnLeave", function() GameTooltip:Hide() end)