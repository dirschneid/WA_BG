-- DoIt by Basil Uzhanov
-- Paint the square according to the next priority abbility


local DoItUpdate=true
local DoItNext="none"
local DoItPrev
local spell = "none"
local spell1 = "none"

local advance = 0.25
local reDoT = 1.5
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
	
	WorldFrame:ClearAllPoints()
	WorldFrame:SetPoint("TOPLEFT", 0, -height)
	WorldFrame:SetPoint("BOTTOMRIGHT", 0, 0)
-- Fire mage
			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Fire Mage")
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountFireMage()
						if DoItNext ~= DoItPrev then
							DoItSetFireMage(DoItNext)
						end
					end
				end
			)
end





T["Scorch"] = GetSpellInfo(2948) -- 22
T["Living Bomb"] = GetSpellInfo(44457) -- 60
T["Fireball"] = GetSpellInfo(133) -- 1
T["Frostfire Bolt"] = GetSpellInfo(44614) -- 75
T["Pyroblast"] = GetSpellInfo(11366) -- 20
T["Molten Armor"] = GetSpellInfo(30482) -- 62
T["Arcane Brilliance"] = GetSpellInfo(1459) -- 1
T["Combustion"] = GetSpellInfo(11129) -- 40
T["Flame Orb"] = GetSpellInfo(82731) -- 100

T["Mana Gem"] = 36799 -- 77

T["Mage Armor"] = GetSpellInfo(6117) -- 30
T["Frost Armor"] = GetSpellInfo(7302) -- 30
T["Critical Mass"] = GetSpellInfo(22959) -- 25
T["Hot Streak"] = GetSpellInfo(48108) -- 50
T["Dalaran Brilliance"] = GetSpellInfo(61316) -- 80
T["Ignite"] = GetSpellInfo(12654) -- 80
T["Pyroblast!"] = GetSpellInfo(92315) -- 20
T["Shadow and Flame"] = GetSpellInfo(17800) -- 100
T["Pero"] = GetSpellInfo(98764) --XXXX

function DoItRecountFireMage()
	DoItNext = "none"

	if not InCombatLockdown() or UnitCanAttack("player","target") == nil then
		spell = "none"
		return
	end

	local start, duration, usable, inrange, index
--	local _, _, lag = GetNetStats()
	
--	local precast = min(lag / 1000 , 0.4)

	local spellch, _, _, _, startTime, endTime = UnitChannelInfo("PLAYER")
--	if spellch and ( select(2, math.modf((GetTime()+advance-startTime/1000)*5000/(endTime-startTime))) > 2*advance/(endTime-startTime)) then
	if spellch then
		return
	end
	if spellch == nil then
		spellch = "none"
	end

	usable, _ = IsUsableItem(T["Mana Gem"])
	if usable and UnitManaMax("player") - UnitMana("player") > 13000  then
		start, duration = GetItemCooldown(T["Mana Gem"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Mana Gem"
			spell1 = DoItNext
			DoItMnRst()
			return
		end
	end
	
	if IsSpellInRange(T["Fireball"],"TARGET")~=1 or not DoItMnRdy() then
		if spell1 ~= nil then
			spell = spell1
		end
		return
	end

	spell1, _, _, _, _, endTime = UnitCastingInfo("PLAYER")
	if spell1 ~= nil then
		spell = spell1
	end
	if spell1 and ((endTime/1000 - GetTime()) > precast) then
		return
	end

	start, duration = GetSpellCooldown(T["Arcane Brilliance"])
	if start and (start + duration - GetTime() > advance) then
		return
	end

	local IsStill = (GetUnitSpeed("player") == 0)

	local Scorch = (UnitLevel("target") ~= -1)
	local Bomb = false
	local Ignite = false
	local Pyroblast = false
	index = 1
	
	while UnitDebuff("target", index) do
		local name, _, _, count, _, _, DoTExpires, isMine = UnitDebuff("target", index)
		if name == T["Critical Mass"] or name == T["Shadow and Flame"] then
			Scorch = true
		end
		if name == T["Living Bomb"] and isMine == "player" then
			Bomb = true
		end
		if name == T["Ignite"] and isMine == "player" then
			Ignite = true
		end
		if (name == T["Pyroblast"] or name == T["Pyroblast!"]) and isMine == "player" then
			Pyroblast = true
		end
		index = index + 1
	end

	local Armor = false
	local Inta = false
	local HS = false
	index = 1
	
	while UnitBuff("PLAYER", index) do
		local name, _, _, count = UnitBuff("PLAYER", index)
		if name == T["Molten Armor"] or name == T["Mage Armor"] or name == T["Frost Armor"] then
			Armor = true
		elseif name == T["Arcane Brilliance"] or name == T["Dalaran Brilliance"] then
			Inta = true
		elseif name == T["Hot Streak"] then
			HS = true
		elseif name == T["Pero"] then
			IsStill = true
		end
		index = index + 1
	end
	
	if not Scorch and not HS and spell ~= T["Scorch"] and IsStill then
		usable, _ = IsUsableSpell(T["Scorch"])
		if usable and (IsSpellInRange(T["Scorch"],"TARGET") == 1) then
			local _, _, _, _, currRank = GetTalentInfo(2,20)
			start, duration = GetSpellCooldown(T["Scorch"])
			if start and (start + duration - GetTime() < advance) and currRank == 3 then
				DoItNext = "Scorch"
				DoItMnRst()
				return
			end
		end
	end

	usable, _ = IsUsableSpell(T["Combustion"])
	if usable and Bomb and Ignite and Pyroblast then
		start, duration = GetSpellCooldown(T["Combustion"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Combustion"
			spell1 = DoItNext
			DoItMnRst()
			return
		end
	end
	
	if not Bomb then
		usable, _ = IsUsableSpell(T["Living Bomb"])
		if usable and (IsSpellInRange(T["Living Bomb"],"TARGET") == 1) then
			start, duration = GetSpellCooldown(T["Living Bomb"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Living Bomb"
				spell1 = DoItNext
				DoItMnRst()
				return
			end
		end
	end
	
	if HS then
		usable, _ = IsUsableSpell(T["Pyroblast"])
		if usable and (IsSpellInRange(T["Pyroblast"],"TARGET") == 1) then
			start, duration = GetSpellCooldown(T["Pyroblast"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Pyroblast"
				spell1 = DoItNext
				DoItMnRst()
				return
			end
		end
	end

	usable, _ = IsUsableSpell(T["Flame Orb"])
	if usable then
		start, duration = GetSpellCooldown(T["Flame Orb"])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = "Flame Orb"
			spell1 = DoItNext
			DoItMnRst()
			return
		end
	end

	if not Armor then
		start, duration = GetSpellCooldown(T["Molten Armor"])
		usable, _ = IsUsableSpell(T["Molten Armor"])
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = "Molten Armor"
			spell1 = DoItNext
			DoItMnRst()
			return
		end
	end
	
	if not Inta then
		start, duration = GetSpellCooldown(T["Arcane Brilliance"])
		usable, _ = IsUsableSpell(T["Arcane Brilliance"])
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = "Arcane Brilliance"
			spell1 = DoItNext
			DoItMnRst()
			return
		end
	end

	start, duration = GetSpellCooldown(T["Fireball"])
	usable, _ = IsUsableSpell(T["Fireball"])
	if start and usable and (start + duration - GetTime() < advance) and IsStill and (UnitMana("player") / UnitManaMax("player") > 0.25 * UnitHealth("target") / UnitHealthMax("target")) then
		DoItNext = "Fireball"
		DoItMnRst()
		return
	end
	
	usable, _ = IsUsableSpell(T["Scorch"])
	if usable and (IsSpellInRange(T["Scorch"],"TARGET") == 1) then
		local _, _, _, _, currRank = GetTalentInfo(2,15)
		start, duration = GetSpellCooldown(T["Scorch"])
		if start and (start + duration - GetTime() < advance) and (currRank == 1 or IsStill) then
			DoItNext = "Scorch"
			DoItMnRst()
			return
		end
	end

	return
end

function DoItSetFireMage(donext)
--	DEFAULT_CHAT_FRAME:AddMessage("---")
--	DEFAULT_CHAT_FRAME:AddMessage(spell)
--	DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Scorch" then
		DoItColorCode(1)
	elseif donext == "Living Bomb" then
		DoItColorCode(2)
	elseif donext == "Fireball" then
		DoItColorCode(3)
	elseif donext == "Pyroblast" then
		DoItColorCode(4)
	elseif donext == "Molten Armor" then
		DoItColorCode(5)
	elseif donext == "Arcane Brilliance" then
		DoItColorCode(6)
	elseif donext == "Mana Gem" then
		DoItColorCode(7)
	elseif donext == "Combustion" then
		DoItColorCode(8)
	elseif donext == "Flame Orb" then
		DoItColorCode(9)
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



