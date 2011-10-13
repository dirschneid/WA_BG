-- 26.05.2010
-- DoIt by Basil Uzhanov
-- Paint the square according to the next priority abbility

local DoItUpdate=true
local DoItNext="none"
local DoItPrev
local spell = "none"
local spell1 = "none"
local DoItCombat 

local advance = 0.25
local reDoT = 1.5
local UtlCD = 4
local UtlTick = 0.2
local LastUtl =0
local MnCD = 0.4
local LastMn = 0
local precast = 0.35

local PrUnit = "none"


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

	-- Hunter MM
			DEFAULT_CHAT_FRAME:AddMessage("DoIt: Surv Hunter")
			DoItCombat = HuntCombatSurv
			DoItFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			DoItFrame:SetScript("OnUpdate", 
				function()
					if DoItUpdate then
						DoItPrev=DoItNext
						DoItRecountHuntSurv()
						if DoItNext ~= DoItPrev then
							DoItSetHuntSurv(DoItNext)
						end
					end
				end
			)
end




T["Serpent Sting"] = GetSpellInfo(1978) -- 4
T["Explosive Shot"] = GetSpellInfo(53301) -- 100
T["Kill Shot"] = GetSpellInfo(53351) -- 71
T["Black Arrow"] = GetSpellInfo(3674) -- 100
T["Arcane Shot"] = GetSpellInfo(3044) -- 6
T["Steady Shot"] = GetSpellInfo(56641) -- 50
T["Hunter's Mark"] = GetSpellInfo(1130) -- 6
T["Mend Pet"] = GetSpellInfo(136) -- 12
T["Aspect of the Hawk"] = GetSpellInfo(13165) -- 100
T["Aspect of the Fox"] = GetSpellInfo(82661) -- 100
T["Pero"] = GetSpellInfo(98764) --XXXX


local DbfTry = 0
local LastSting = 0
local LastExpl = 0
local Stopped = 0

function HuntCombatSurv( ... )
	local timestamp, type, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
    if (type=="SPELL_MISSED") and (destGUID == UnitGUID("target")) then
		local spellId, spellName, spellSchool, missType = select(9, ...)
--		print(spellName)
		if missType == "IMMUNE" and spellName == T["Serpent Sting"] then
			DbfTry = 10
--			print("Unplagueable")
		end
	end
end

function DoItRecountHuntSurv()
	local start, duration, usable, nomana, index, spell
	
	DoItNext = "none"

	if not InCombatLockdown() or UnitCanAttack("player","target") == nil then
		DbfTry = 0
		return
	end

	local IsStill = (GetUnitSpeed("player") == 0)
	
	if IsStill then
		if Stopped == 0 then
			Stopped = GetTime()
		end
	else
		Stopped = 0
	end

	spell1, _, _, _, _, endTime = UnitCastingInfo("PLAYER")
	if spell1 and endTime and ((endTime/1000 - GetTime()) > precast) then
		return
	end
	
	index = 1
	local AotF = false
	while UnitBuff("PLAYER", index) do
		local name, _, _, _, _, _, expire, IsMine = UnitBuff("PLAYER", index)
		if name == T["Aspect of the Fox"] then
			AotF = true
		elseif name == T["Pero"] then
			IsStill = true
		end
		index = index + 1
	end
	
	spell = "Aspect of the Hawk"
	usable, _ = IsUsableSpell(T[spell])
	if usable and IsStill and AotF and GetTime() - Stopped > 1.5 then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			DoItMnRst()
			return
		end
	end
	
	spell = "Aspect of the Fox"
	usable, _ = IsUsableSpell(T[spell])
	if usable and not IsStill and not AotF and UnitPower("player") < 45 then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			DoItMnRst()
			return
		end
	end
	
	start, duration = GetSpellCooldown(T["Serpent Sting"])
	if start and (start + duration - GetTime() > advance) then
		return
	end
	
	if IsSpellInRange(T["Serpent Sting"],"TARGET")~=1 then
		return
	end

	local CUnit = UnitGUID("target")
	if CUnit ~= nil and CUnit ~= PrUnit then
		PrUnit = CUnit
		DbfTry = 0
	end

	index = 1
	local ST = false
	local HM = false
	while UnitDebuff("target", index) do
		local name, _, _, count, _, _, shockExpires, isMine = UnitDebuff("target", index)
		if name == T["Hunter's Mark"] or name == T["Marked for Death"] then
			HM = true
		elseif isMine and isMine == "player" then
			if name == T["Serpent Sting"] then
				ST = true
				DbfTry = 0
			end
		end
		index = index + 1
	end

	index = 1
	local MP = not (UnitExists("pet") and UnitHealth("pet") > 0)
	if not MP then
		while UnitBuff("pet", index) do
			local name, _, _, _, _, _, expire, IsMine = UnitBuff("pet", index)
			if name == T["Mend Pet"] then
				MP = true
			end
			index = index + 1
		end
	end
	
	if not HM then
		usable, _ = IsUsableSpell(T["Hunter's Mark"])
		if usable then
			start, duration = GetSpellCooldown(T["Hunter's Mark"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Hunter's Mark"
				return
			end
		end
	end
	
	if DbfTry < 2 and not ST and (GetTime() - LastSting < UtlTick or GetTime() - LastSting > 2) then
		usable, _ = IsUsableSpell(T["Serpent Sting"])
		if usable then
			start, duration = GetSpellCooldown(T["Serpent Sting"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Serpent Sting"
				if GetTime() - LastSting > UtlTick then
					LastSting = GetTime()
				end
				return
			end
		end
	end
	
	spell = "Explosive Shot"
	usable, nomana = IsUsableSpell(T[spell])
	local ExpRes = 0
	if (usable or nomana) then
		start, duration = GetSpellCooldown(T[spell])
		local _, _, _, costExp = GetSpellInfo(T["Explosive Shot"])
		local ToExSh = start + duration - GetTime()
		ExpRes = costExp * (1 - ToExSh / 8)
		if start and usable and (ToExSh < advance) and (GetTime() - LastExpl < UtlTick or GetTime() - LastExpl > 1.7) then
			DoItNext = spell
			if GetTime() - LastExpl > UtlTick then
				LastExpl = GetTime()
			end
			return
		end
	end
	
	spell = "Kill Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			return
		end
	end
	
	spell = "Black Arrow"
	usable, nomana = IsUsableSpell(T[spell])
	local BlRes = 0
	if (usable or nomana) then
		start, duration = GetSpellCooldown(T[spell])
		local _, _, _, costBl = GetSpellInfo(T["Black Arrow"])
		BlRes = costBl * (1 - (start + duration - GetTime()) / 6)
		if BlRes < 0 then
			BlRes = 0
		end
		if start and usable and (start + duration - GetTime() < advance) then
			DoItNext = spell
			return
		end
	end
	
	local _, _, _, costArc = GetSpellInfo(T["Arcane Shot"])
	spell = "Arcane Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable and costArc > 0 and UnitPower("player") > ExpRes + BlRes + costArc then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			return
		end
	end
	
	if not MP and (UnitHealth("pet") / UnitHealthMax("pet") < 0.7) then
		usable, _ = IsUsableSpell(T["Mend Pet"])
		if usable then
			start, duration = GetSpellCooldown(T["Mend Pet"])
			if start and (start + duration - GetTime() < advance) then
				DoItNext = "Mend Pet"
				return
			end
		end
	end
	
	spell = "Steady Shot"
	usable, _ = IsUsableSpell(T[spell])
	if usable then
		start, duration = GetSpellCooldown(T[spell])
		if start and (start + duration - GetTime() < advance) then
			DoItNext = spell
			return
		end
	end
	
	return
end

function DoItSetHuntSurv(donext)
--	DEFAULT_CHAT_FRAME:AddMessage(donext)
	if donext == "none" then
		DoItColorCode(0)
	elseif donext == "Serpent Sting" then
		DoItColorCode(1)
	elseif donext == "Explosive Shot" then
		DoItColorCode(2)
	elseif donext == "Kill Shot" then
		DoItColorCode(3)
	elseif donext == "Black Arrow" then
		DoItColorCode(4)
	elseif donext == "Arcane Shot" then
		DoItColorCode(5)
	elseif donext == "Steady Shot" then
		DoItColorCode(6)
	elseif donext == "Hunter's Mark" then
		DoItColorCode(7)
	elseif donext == "Mend Pet" then
		DoItColorCode(8)
	elseif donext == "Aspect of the Hawk" then
		DoItColorCode(9)
	elseif donext == "Aspect of the Fox" then
		DoItColorCode(10)
	elseif donext == "" then
		DoItColorCode(11)
	elseif donext == "" then
		DoItColorCode(12)
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

local function eventHandler(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		DoItCombat( ... )
	else
		DiItInit()
	end
	return
end

DoItFrame:SetScript("OnEvent", eventHandler);


