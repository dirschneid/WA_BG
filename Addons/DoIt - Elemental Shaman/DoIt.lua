-- DoIt by Basil Uzhanov
-- Paint the square according to the next priority abbility


local DoItUpdate=true
local DoItNext="none"
local DoItPrev
local spell = "none"
local spell1 = "none"

local advance = 0.25
local reDoT = 1.25
local UtlCD = 4
local UtlTick = 0.2
local LastUtl =0
local MnCD = 0.4
local LastMn = 0
local precast = 0.35


local DoItFrame=CreateFrame("Frame",nil,WorldFrame)
-- Create the square itself
DoItFrame.t = DoItFrame:CreateTexture()
local width = 2
local height = 2
DoItFrame:ClearAllPoints()
DoItFrame:SetScale(1)
DoItFrame:SetFrameStrata("TOOLTIP")
DoItFrame:SetWidth(width)
DoItFrame:SetHeight(height)
DoItFrame:SetPoint("TOPLEFT",UIParent)
DoItFrame.t:SetAllPoints(DoItFrame)
DoItFrame.t:SetTexture(0,0,0)
DoItFrame:Show()

local T = {}

local function DiItInit()
	-- Check Who am I?
	
	WorldFrame:ClearAllPoints()
	WorldFrame:SetPoint("TOPLEFT", 0, -height)
	WorldFrame:SetPoint("BOTTOMRIGHT", 0, 0)

			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Elem Shammy")
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountElem()
						if DoItNext ~= DoItPrev then
							DoItSetElem(DoItNext)
						end
					end
				end
			)
end


T["Chain Lightning"] = GetSpellInfo(421) -- 40
T["Lightning Bolt"] = GetSpellInfo(403) -- 1
T["Flame Shock"] = GetSpellInfo(8050) -- 10
T["Earth Shock"] = GetSpellInfo(8042) -- 4
T["Lava Burst"] = GetSpellInfo(51505) -- 45
T["Elemental Mastery"] = GetSpellInfo(16166) -- 50
T["Searing Totem"] = GetSpellInfo(3599) -- 26
T["Wrath of Air Totem"] = GetSpellInfo(3738) -- 32
T["Mana Spring Totem"] = GetSpellInfo(5675) -- 26
T["Strength of Earth Totem"] = GetSpellInfo(8075) -- 10
T["Wind Shear"] = GetSpellInfo(57994) -- 16
T["Lightning Shield"] = GetSpellInfo(324) -- 8
T["Flametongue Weapon"] = GetSpellInfo(8024) -- 1
T["Thunderstorm"] = GetSpellInfo(51490) -- 12
T["Purge"] = GetSpellInfo(370) -- 12
T["Pero"] = GetSpellInfo(98764) --XXXX

function DoItRecountElem()
	local start, duration, usable, LBLeft, index
--	local _, _, lag = GetNetStats()
	
	DoItNext = "none"

	if not InCombatLockdown() or UnitCanAttack("player","target") == nil then
		spell = "none"
		return
	end

--	local precast = min(lag / 1000 , 0.4)

	spell1, _, _, _, _, endTime = UnitCastingInfo("PLAYER")
	if spell1 ~= nil then
		spell = spell1
	end
	if spell1 and ((endTime/1000 - GetTime()) > precast) then
		return
	end
	
	local spellch, _, _, _, startTime, endTime = UnitChannelInfo("PLAYER")
	if spellch and (endTime / 1000 - GetTime() > advance) then
		spell = spellch
		return
	end
	
	local IsStill = (GetUnitSpeed("player") == 0)	
	
	index = 1	
	while UnitBuff("PLAYER", index) do
		local name, _, _, _ = UnitBuff("PLAYER", index)
		if name == T["Pero"] then
			IsStill = true
		end
		index = index + 1
	end
	
	if IsSpellInRange(T["Flame Shock"],"TARGET")~=1 then
		return
	end

	usable, _ = IsUsableSpell(T["Wind Shear"])
	if usable and IsSpellInRange(T["Wind Shear"],"TARGET")==1 then
		local spell, _, _, _, _, endTime, _, _, notinterrupt = UnitCastingInfo("TARGET")
		if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.2) then
			start, duration = GetSpellCooldown(T["Wind Shear"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Wind Shear"
				return
			end
		end

		local spell, _, _, _, _, endTime, _, notinterrupt = UnitChannelInfo("TARGET")
		if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.2) then
			start, duration = GetSpellCooldown(T["Wind Shear"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Wind Shear"
				return
			end
		end
	end

	usable, _ = IsUsableSpell(T["Elemental Mastery"])
	if usable then
		start, duration = GetSpellCooldown(T["Elemental Mastery"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Elemental Mastery"
			return
		end
	end
	
	if not DoItMnRdy() then
		return
	end
	
	start, duration = GetSpellCooldown(T["Lightning Shield"])
	if start and (start + duration - GetTime() > advance) then
		return
	end

	start, duration = GetSpellCooldown(T["Lava Burst"])
	if start ~=0 then
		LBLeft = start + duration - GetTime()
	else
		LBLeft = 0
	end

	local _, tname, tstart, tduration = GetTotemInfo(1)
	if not tname or tname == "" or (tstart + tduration - GetTime() < 2) then
		start, duration = GetSpellCooldown(T["Searing Totem"])
		usable, _ = IsUsableSpell(T["Searing Totem"])
		if start and usable and (start + duration - GetTime() < advance) and IsSpellInRange(T["Wind Shear"],"TARGET") == 1 then
			DoItNext = "Searing Totem"
			DoItMnRst()
			return
		end
	end
	
	if IsStill then
		usable, _ = IsUsableSpell(T["Lava Burst"])
	else
		usable = false
	end

	index = 1
	local FS = false
	local TW = true
	while UnitDebuff("target", index) do
		local name, _, _, count, _, _, shockExpires, isMine = UnitDebuff("target", index)
		if isMine and name == T["Flame Shock"] and isMine == "player" then
			local _, _, _, _, _, _, castTime, _, _ = GetSpellInfo(T["Lava Burst"])
			FS = (LBLeft + castTime / 1000 < (shockExpires - GetTime()))
			if start and usable and FS and LBLeft < advance and spell ~= T["Lava Burst"] then
				DoItNext = "Lava Burst"
				DoItMnRst()
				return
			end
		end
		index = index + 1
	end
	
	index = 1
	local ShOK = 0
	while UnitBuff("PLAYER", index) do
		local name, _, _, count = UnitBuff("PLAYER", index)
		if count > 1 and name == T["Lightning Shield"] then
			ShOK = count
		end
		index = index + 1
	end
	
	if not FS then
		start, duration = GetSpellCooldown(T["Flame Shock"])
		usable, _ = IsUsableSpell(T["Flame Shock"])
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = "Flame Shock"
			DoItMnRst()
			return
		end
	end

	if ShOK < 3 then
		start, duration = GetSpellCooldown(T["Lightning Shield"])
		usable, _ = IsUsableSpell(T["Lightning Shield"])
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = "Lightning Shield"
			DoItMnRst()
			return
		end
	end

	if ShOK > 6 then
		start, duration = GetSpellCooldown(T["Earth Shock"])
		usable, _ = IsUsableSpell(T["Earth Shock"])
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = "Earth Shock"
			DoItMnRst()
			return
		end
	end

	if DoItUtlRdy() then

		if not GetWeaponEnchantInfo() then
			start, duration = GetSpellCooldown(T["Flametongue Weapon"])
			usable, _ = IsUsableSpell(T["Flametongue Weapon"])
			if start and usable and (start + duration - GetTime() < advance) then
				DoItNext = "Flametongue Weapon"
				DoItUtlRst()
				return
			end
		end

		local _, tname, tstart, tduration = GetTotemInfo(4)
		if not tname or tname == "" or (tstart + tduration - GetTime() < 3 * UtlCD) then
			start, duration = GetSpellCooldown(T["Wrath of Air Totem"])
			usable, _ = IsUsableSpell(T["Wrath of Air Totem"])
			if start and usable and (start + duration - GetTime() < advance) then
				DoItNext = "Wrath of Air Totem"
				DoItUtlRst()
				return
			end
		end
		
		local _, tname, tstart, tduration = GetTotemInfo(3)
		if not tname or tname == "" or (tstart + tduration - GetTime() < 3 * UtlCD) then
			start, duration = GetSpellCooldown(T["Mana Spring Totem"])
			usable, _ = IsUsableSpell(T["Mana Spring Totem"])
			if start and usable and (start + duration - GetTime() < advance) then
				DoItNext = "Mana Spring Totem"
				DoItUtlRst()
				return
			end
		end

		local _, tname, tstart, tduration = GetTotemInfo(2)
		if not tname or tname == "" or (tstart + tduration - GetTime() < 3 * UtlCD) then
			start, duration = GetSpellCooldown(T["Strength of Earth Totem"])
			usable, _ = IsUsableSpell(T["Strength of Earth Totem"])
			if start and usable and (start + duration - GetTime() < advance) then
				DoItNext = "Strength of Earth Totem"
				DoItUtlRst()
				return
			end
		end

		start, duration = GetSpellCooldown(T["Thunderstorm"])
		usable, _ = IsUsableSpell(T["Thunderstorm"])
		if start and usable and (start + duration - GetTime() < advance) and (UnitMana("player") / UnitManaMax("player") < UnitHealth("target") / UnitHealthMax("target") * 0.2 + 0.1) then
			DoItNext = "Thunderstorm"
			DoItUtlRst()
			return
		end

		if IsSpellInRange(T["Purge"],"TARGET")==1 then
			index = 1
			while UnitBuff("target", index) do
				local _, _, _, _,buffType, _, _, _, isStealable = UnitBuff("target", index)
--				if buffType == "Magic" and isStealable == 1 then
				if buffType == "Magic" then
					start, duration = GetSpellCooldown(T["Purge"])
					usable, _ = IsUsableSpell(T["Purge"])
					if start and usable and (start + duration - GetTime() < advance) then
						DoItNext = "Purge"
						DoItUtlRst()
						return
					end
				end
				index = index + 1
			end
		end
	end
	

	start, duration = GetSpellCooldown(T["Chain Lightning"])
	usable, _ = IsUsableSpell(T["Chain Lightning"])
--	if start and usable and (start + duration - GetTime() < advance) and (UnitMana("player") / UnitManaMax("player") > UnitHealth("target") / UnitHealthMax("target") * 0.9) and spell ~= "Цепная молния" then
	if IsStill and start and usable and (start + duration - GetTime() < advance) and (UnitLevel("target") ~= -1) and spell ~= T["Chain Lightning"] then
		DoItNext = "Chain Lightning"
		DoItMnRst()
		return
	end

	start, duration = GetSpellCooldown(T["Lightning Bolt"])
	usable, _ = IsUsableSpell(T["Lightning Bolt"])
	if IsStill and start and usable and (start + duration - GetTime() < advance) then
		DoItNext = "Lightning Bolt"
		DoItMnRst()
		return
	end
	
	return
end

function DoItSetElem(donext)
--	DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Chain Lightning" then
		DoItColorCode(1)
	elseif donext == "Lightning Bolt" then
		DoItColorCode(2)
	elseif donext == "Flame Shock" then
		DoItColorCode(3)
	elseif donext == "Earth Shock" then
		DoItColorCode(4)
	elseif donext == "Lava Burst" then
		DoItColorCode(5)
	elseif donext == "Elemental Mastery" then
		DoItColorCode(6)
	elseif donext == "Searing Totem" then
		DoItColorCode(7)
	elseif donext == "Wrath of Air Totem" then
		DoItColorCode(8)
	elseif donext == "Mana Spring Totem" then
		DoItColorCode(9)
	elseif donext == "Strength of Earth Totem" then
		DoItColorCode(10)
	elseif donext == "Wind Shear" then
		DoItColorCode(11)
	elseif donext == "Lightning Shield" then
		DoItColorCode(12)
	elseif donext == "Flametongue Weapon" then
		DoItColorCode(13)
	elseif donext == "Thunderstorm" then
		DoItColorCode(14)
	elseif donext == "Purge" then
		DoItColorCode(15)
	end

	return
end





function DoItColorCode(code)
 	-- LowHealthFrame:Hide()
	-- LowHealthFrame:SetAlpha(0)
    if code == 0 then
          DoItFrame.t:SetTexture(0,0,0)
     elseif code == 1 then
          DoItFrame.t:SetTexture(0.047,0,0)
     elseif code == 2 then
          DoItFrame.t:SetTexture(0.094,0,0)
     elseif code == 3 then
          DoItFrame.t:SetTexture(0,0.047,0)
     elseif code == 4 then
          DoItFrame.t:SetTexture(0.047,0.047,0)
     elseif code == 5 then
          DoItFrame.t:SetTexture(0.094,0.047,0)
     elseif code == 6 then
          DoItFrame.t:SetTexture(0,0.094,0)
     elseif code == 7 then
          DoItFrame.t:SetTexture(0.047,0.094,0)
     elseif code == 8 then
          DoItFrame.t:SetTexture(0.094,0.094,0)
     elseif code == 9 then
          DoItFrame.t:SetTexture(0,0,0.047)
     elseif code == 10 then
          DoItFrame.t:SetTexture(0.047,0,0.047)
     elseif code == 11 then
          DoItFrame.t:SetTexture(0.094,0,0.047)
     elseif code == 12 then
          DoItFrame.t:SetTexture(0,0.047,0.047)
     elseif code == 13 then
          DoItFrame.t:SetTexture(0.047,0.047,0.047)
     elseif code == 14 then
          DoItFrame.t:SetTexture(0.094,0.047,0.047)
     elseif code == 15 then
          DoItFrame.t:SetTexture(0,0.094,0.047)
     elseif code == 16 then
          DoItFrame.t:SetTexture(0.047,0.094,0.047)
     
     end

     return
end


function DoItUtlRdy()
	return ((GetTime() - LastUtl) > UtlCD) or ((GetTime() - LastUtl) < UtlTick)
end

function DoItUtlRst()
	if (GetTime() - LastUtl) > 2*UtlTick then
		LastUtl = GetTime()
		LastMn = GetTime()
	end
	return
end

function DoItMnRdy()
	return ((GetTime() - LastMn) > MnCD) or ((GetTime() - LastMn) < UtlTick)
end

function DoItMnRst()
	if (GetTime() - LastMn) > 2*UtlTick then
		LastMn = GetTime()
	end
	return
end

DoItFrame:RegisterEvent("PLAYER_ALIVE");
DoItFrame:RegisterEvent("PLAYER_LOGIN");
DoItFrame:RegisterEvent("PLAYER_TALENT_UPDATE");
DoItFrame:SetScript("OnEvent", DiItInit);


