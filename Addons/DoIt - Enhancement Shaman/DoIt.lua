-- DoIt by Basil Uzhanov
-- Paint the square according to the next priority abbility

local DoItUpdate=true
local DoItNext="none"
local DoItPrev
local spell = "none"
local spell1 = "none"

local advance = 0.3
local reDoT = 1.25
local UtlCD = 4
local UtlTick = 0.2
local LastUtl =0
local MnCD = 0.4
local LastMn = 0
local precast = 0.4

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

			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Mili Shammy")
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountEnh()
						if DoItNext ~= DoItPrev then
							DoItSetEnh(DoItNext)
						end
					end
				end
			)

end


T["Stormstrike"] = GetSpellInfo(17364) -- 40
T["Lightning Bolt"] = GetSpellInfo(403) -- 1
T["Earth Shock"] = GetSpellInfo(8042) -- 4
T["Lava Lash"] = GetSpellInfo(60103) -- 45
T["Lightning Shield"] = GetSpellInfo(324) -- 8
T["Unleash Elements"] = GetSpellInfo(73680) -- хз что это за цифры, поэтому не пишу
T["Wind Shear"] = GetSpellInfo(57994) -- 16
T["Searing Totem"] = GetSpellInfo(3599) -- 26
T["Windfury Totem"] = GetSpellInfo(8512) -- 32
T["Mana Spring Totem"] = GetSpellInfo(5675) -- 26
T["Strength of Earth Totem"] = GetSpellInfo(8075) -- 10
T["Purge"] = GetSpellInfo(370) -- 12
T["Healing Wave"] = GetSpellInfo(331) -- 1
T["Fire Nova"] = GetSpellInfo(1535) -- 12
T["Flame Shock"] = GetSpellInfo(8050) -- 10


T["Water Shield"] = GetSpellInfo(52127) -- 20
T["Improved Icy Talons"] = GetSpellInfo(55610) -- 35
T["Hunting Party"] = GetSpellInfo(53290) -- 35
T["Maelstrom Weapon"] = GetSpellInfo(53817) -- 55
T["Strength of Earth"] = GetSpellInfo(8076) -- 10
T["Horn of Winter"] = GetSpellInfo(57330) -- 100
T["Roar of Courage"] = GetSpellInfo(93435) -- 100
T["Battle Shout"] = GetSpellInfo(6673) -- 100
T["Flametongue Totem"] = GetSpellInfo(8227) -- 26
T["Magma Totem"] = GetSpellInfo(8190) -- 26
T["Fire Elemental Totem"] = GetSpellInfo(2894) -- 26
T["Unleash Flame"] = GetSpellInfo(73683) -- 26
T["Pero"] = GetSpellInfo(98764) --XXXX

function DoItRecountEnh()
	local start, duration, usable, index
	
	DoItNext = "none"
	
	local spell, _, _, _, _, endTime = UnitCastingInfo("PLAYER")
	if spell and ((endTime/1000 - GetTime()) > advance) then
		return
	end
	if not InCombatLockdown() or IsSpellInRange(T["Earth Shock"],"TARGET")~=1 or UnitCanAttack("player","target") == nil then
		return
	end

	local IsStill = (GetUnitSpeed("player") == 0)

	
	
	local spell, _, _, _, _, endTime, _, _, notinterrupt = UnitCastingInfo("TARGET")
	if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.2) then
		start, duration = GetSpellCooldown(T["Wind Shear"])
		usable, _ = IsUsableSpell(T["Wind Shear"])
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = "Wind Shear"
			return
		end
	end

	local spell, _, _, _, _, endTime, _, notinterrupt = UnitChannelInfo("TARGET")
	if spell and not notinterrupt and ((endTime/1000 - GetTime()) > 0.2) then
		start, duration = GetSpellCooldown(T["Wind Shear"])
		usable, _ = IsUsableSpell(T["Wind Shear"])
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = "Wind Shear"
			return
		end
	end

	start, duration = GetSpellCooldown(T["Lightning Shield"])
	if start and (start + duration - GetTime() > advance) then
		return
	end

	index = 1
	local ShOK = 0
	local AirOK = false
	local EarthOK = false
	local MWOK = false
	local UFOK = false
	while UnitBuff("PLAYER", index) do
		local name, _, _, count = UnitBuff("PLAYER", index)
		if count > 1 and (name == T["Water Shield"] or name == T["Lightning Shield"]) then
			ShOK = count
		end
		if name == T["Windfury Totem"] or name == T["Improved Icy Talons"] or name == T["Hunting Party"] then
			AirOK = true
		end
		if name == T["Maelstrom Weapon"] and count == 5 then
			MWOK = true
		end
		if name == T["Strength of Earth"] or name == T["Horn of Winter"] or name == T["Roar of Courage"] or name == T["Battle Shout"] then
			EarthOK = true
		end
		if name == T["Unleash Flame"] then
			UFOK = true
		end
		if name == T["Pero"] then
			IsStill = true
		end
		index = index + 1
	end

	local SSOK = false
	local FSOK = false
	index = 1
	while UnitDebuff("target", index) do
		local name, _, _, _, _, _, DoTExpires, isMine = UnitDebuff("target", index)
		if name == T["Stormstrike"] and isMine == "player" and DoTExpires - GetTime() > reDoT then
			SSOK = true
		elseif name == T["Flame Shock"] and isMine == "player" and DoTExpires - GetTime() > reDoT then
			FSOK = true
		end
		index = index + 1
	end

	start, duration = GetSpellCooldown(T["Healing Wave"])
	usable, _ = IsUsableSpell(T["Healing Wave"])
	if IsStill and MWOK and start and usable and (start + duration - GetTime() < advance) and (UnitHealth("player") / UnitHealthMax("player") < 0.8) then
		DoItNext = "Healing Wave"
		return
	end

	local _, tname, tstart, tduration = GetTotemInfo(1)
	if not tname or tname == "" or (tstart + tduration - GetTime() < reDoT) then
		start, duration = GetSpellCooldown(T["Searing Totem"])
		usable, _ = IsUsableSpell(T["Searing Totem"])
		if start and usable and (start + duration - GetTime() < advance) and IsSpellInRange(T["Stormstrike"],"TARGET") == 1 then
			DoItNext = "Searing Totem"
			return
		end
	end
	
	start, duration = GetSpellCooldown(T["Stormstrike"])
	usable, _ = IsUsableSpell(T["Stormstrike"])
	if start and usable and (start + duration - GetTime() < advance) and IsSpellInRange(T["Stormstrike"],"TARGET") == 1 then
		if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
			DoItNext = "Stormstrike"
		end
		return
	end
	
	start, duration = GetSpellCooldown(T["Lava Lash"])
	usable, _ = IsUsableSpell(T["Lava Lash"])
	if IsStill and  start and usable and (start + duration - GetTime() < advance) and IsSpellInRange(T["Stormstrike"],"TARGET") == 1 then
		if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
			DoItNext = "Lava Lash"
		end
		return
	end
	
	start, duration = GetSpellCooldown(T["Lightning Bolt"])
	usable, _ = IsUsableSpell(T["Lightning Bolt"])
	if IsStill and  MWOK and start and usable and (start + duration - GetTime() < advance) then
		DoItNext = "Lightning Bolt"
		return
	end

	start, duration = GetSpellCooldown(T["Flame Shock"])
	usable, _ = IsUsableSpell(T["Flame Shock"])
	if UFOK and start and usable and (start + duration - GetTime() < advance) then
		if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
			DoItNext = "Flame Shock"
		end
		return
	end
	
	usable, _ = IsUsableSpell(T["Unleash Elements"])
	if usable then
		start, duration = GetSpellCooldown(T["Unleash Elements"])
		if start and (start + duration - GetTime() < advance) then
			if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
				DoItNext = "Unleash Elements"
			end
			return
		end
	end
	
	start, duration = GetSpellCooldown(T["Earth Shock"])
	usable, _ = IsUsableSpell(T["Earth Shock"])
	if start and usable and (start + duration - GetTime() < advance) then
		if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
			DoItNext = "Earth Shock"
		end
		return
	end

	local _, tname, tstart, tduration = GetTotemInfo(1)
	usable, _ = IsUsableSpell(T["Fire Nova"])
	if FSOK and tname and usable and (tname == T["Flametongue Totem"] or tname == T["Magma Totem"] or tname == T["Fire Elemental Totem"]) then
		start, duration = GetSpellCooldown(T["Fire Nova"])
		if UnitMana("player") / UnitManaMax("player") > 0.2 and start and usable and (start + duration - GetTime() < advance) then
			if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
				DoItNext = "Fire Nova"
			end
			return
		end
	end
	
	if ShOK < 2 then
		start, duration = GetSpellCooldown(T["Lightning Shield"])
		usable, _ = IsUsableSpell(T["Lightning Shield"])
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = "Lightning Shield"
			return
		end
	end
	
	local _, tname, tstart, tduration = GetTotemInfo(1)
	if not tname or tname == "" or (tstart + tduration - GetTime() < 2) then
		start, duration = GetSpellCooldown(T["Searing Totem"])
		usable, _ = IsUsableSpell(T["Searing Totem"])
		if start and usable and (start + duration - GetTime() < advance) and IsSpellInRange(T["Stormstrike"],"TARGET") == 1 then
			DoItNext = "Searing Totem"
			return
		end
	end

	
	
	
	
	
	
--[[	
	start, duration = GetSpellCooldown(T["Flame Shock"])
	usable, _ = IsUsableSpell(T["Flame Shock"])
	if not FSOK and start and usable and (start + duration - GetTime() < advance) then
		if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
			DoItNext = "Flame Shock"
		end
		return
	end
	
	start, duration = GetSpellCooldown(T["Stormstrike"])
	usable, _ = IsUsableSpell(T["Stormstrike"])
	if not SSOK and start and usable and (start + duration - GetTime() < advance) and IsSpellInRange(T["Stormstrike"],"TARGET") == 1 then
		if (GetTime() - start < 2) or (start + duration - GetTime() < 0.01) then 
			DoItNext = "Stormstrike"
		end
		return
	end

	if ShOK < 1 then
		start, duration = GetSpellCooldown(T["Lightning Shield"])
		usable, _ = IsUsableSpell(T["Lightning Shield"])
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = "Lightning Shield"
			return
		end
	end
	
	]]--

	
	
	if DoItUtlRdy() then
		local _, tname, tstart, tduration = GetTotemInfo(2)
		if not tname or tname == "" or (tstart + tduration - GetTime() < 3 * UtlCD) or ((not EarthOK) and tname == T["Strength of Earth Totem"]) then
			start, duration = GetSpellCooldown(T["Strength of Earth Totem"])
			usable, _ = IsUsableSpell(T["Strength of Earth Totem"])
			if start and usable and (start + duration - GetTime() < advance) then
				DoItNext = "Strength of Earth Totem"
				DoItUtlRst()
				return
			end
		end
		
		local _, tname, tstart, tduration = GetTotemInfo(4)
		if not tname or tname == "" or (tstart + tduration - GetTime() < 3 * UtlCD) or ((not AirOK) and tname == T["Windfury Totem"]) then
			start, duration = GetSpellCooldown(T["Windfury Totem"])
			usable, _ = IsUsableSpell(T["Windfury Totem"])
			if start and usable and (start + duration - GetTime() < advance) then
				DoItNext = "Windfury Totem"
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
	
	return
end

function DoItSetEnh(donext)
--	DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Stormstrike" then
		DoItColorCode(1)
	elseif donext == "Lightning Bolt" then
		DoItColorCode(2)
	elseif donext == "Earth Shock" then
		DoItColorCode(3)
	elseif donext == "Lava Lash" then
		DoItColorCode(4)
	elseif donext == "Lightning Shield" then
		DoItColorCode(5)
	elseif donext == "Unleash Elements" then
		DoItColorCode(6)
	elseif donext == "Wind Shear" then
		DoItColorCode(7)
	elseif donext == "Searing Totem" then
		DoItColorCode(8)
	elseif donext == "Windfury Totem" then
		DoItColorCode(9)
	elseif donext == "Mana Spring Totem" then
		DoItColorCode(10)
	elseif donext == "Strength of Earth Totem" then
		DoItColorCode(11)
	elseif donext == "Purge" then
		DoItColorCode(12)
	elseif donext == "Healing Wave" then
		DoItColorCode(13)
	elseif donext == "Fire Nova" then
		DoItColorCode(14)
	elseif donext == "Flame Shock" then
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

